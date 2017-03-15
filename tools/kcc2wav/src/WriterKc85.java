package de.loet.kassettenrecorder;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class WriterKc85 extends WriterBase {

	static final int FREQ_EINS_BIT = 1048;
	static final int FREQ_NULL_BIT = 2004;
	static final int FREQ_TRENNZEICHEN = 558;
	static final int FREQ_PAUSE = 97;

	static final int SAMPLE_RATE = 44100;
	static final short MAX_LEVEL = 0x3000;

	public static void main(String[] args) {

			String filename = "out.pcm";
			try {
				byte data[] = null;
				int dataPtr = 0;
				int block = 1;
				FileOutputStream out = new FileOutputStream(filename);

				writePeriod(out, 4108, FREQ_EINS_BIT);
				writePeriod(out, 1, FREQ_TRENNZEICHEN);
				System.out.printf("%02x> ", block);
				writeByte(out, block);
				int checksum = 0;
				for (int i = 0; i < 128; i++) {
					byte c = data[dataPtr++];
					checksum += c;
					writeByte(out, c);
				}
				writeByte(out, checksum);
				writePeriod(out, 1, FREQ_PAUSE);

				int blocksLeft = (data.length - 128) / 128;
				while (blocksLeft > 0) {
					writePeriod(out, 160, FREQ_EINS_BIT);
					writePeriod(out, 1, FREQ_TRENNZEICHEN);
					if (blocksLeft > 1) {
						block++;
					} else {
						block = 0xff;
					}
					System.out.printf("%02x> ", block);
					if (block % 15 == 0) {
						System.out.println();
					}
					writeByte(out, block);
					checksum = 0;
					for (int i = 0; i < 128; i++) {
						byte c = data[dataPtr++];
						checksum += c;
						writeByte(out, c);
					}
					writeByte(out, checksum);
					writePeriod(out, 1, FREQ_PAUSE);
					blocksLeft--;
				} // silence
				for (int i = 0; i < SAMPLE_RATE / 2; i++) {
					writeLeShort(out, (short) 0x0);
				}

				out.write(buffer, 0, bufferPtr);
				out.close();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

	private static double xoffset = 1;
	private static int MAX_FREQ = 2400;

	private static void writePeriod(FileOutputStream out, int periods, int freq)
			throws IOException {

		double inc = (freq * 2 * Math.PI) / SAMPLE_RATE;

		double ratio = MAX_FREQ;
		ratio /= freq;

		double j = (1 - xoffset) * inc;
		short y1 = 0;
		for (; j < 2 * Math.PI * periods; j += inc) {
			// System.out.printf("j=%f ", j);

			double sin = Math.sin(j);
			double ofs = j % Math.PI;

			double val = 1;
			// if (sin > 0) {
			if (ofs * ratio < Math.PI / 2) {
				val = Math.sin(ofs * ratio);
			} else if ((Math.PI - ofs) * ratio < Math.PI / 2) {
				val = Math.sin(ratio * (Math.PI - ofs));
			}
			if (sin < 0)
				val = -val;

			val *= MAX_LEVEL;
			y1 = (short) Math.round(val);
			// System.out.println(d);
			writeLeShort(out, y1);
		}
		// the last value reaches Zero or cross the line
		// this intersection is the start for the new wave-next time the method
		// is called
		double val = Math.sin(j);
		val *= MAX_LEVEL;
		short y2 = (short) Math.round(val);

		xoffset = -y1; // -b
		if ((-y1 + y2) != 0) {
			xoffset /= (-y1 + y2); // a
		}
		// System.out.printf("x1=%d x2=%d x=%f\n",y1,y2,xoffset);
	}

	private static void fillBlock01(int[] buf) {
		buf[0] = 'S';
		buf[1] = 'A';
		buf[2] = 'M';
		buf[3] = 'P';
		buf[4] = 'L';
		buf[5] = 'E';
		buf[16] = 0x02;
		buf[17] = 0x00;
		buf[18] = 0x04;
		buf[19] = 0xff;
		buf[20] = 0x07;
		buf[21] = 0x1f;
		buf[22] = 0x01;
	}

	private static void writeByte(FileOutputStream out, int value)
			throws IOException {
		for (int i = 0; i < 8; i++) {
			if ((value & 1) == 1) {
				writePeriod(out, 1, FREQ_EINS_BIT);
			} else {
				writePeriod(out, 1, FREQ_NULL_BIT);
			}
			value >>>= 1;
		}
		writePeriod(out, 1, FREQ_TRENNZEICHEN);
	}

	private static void writePeriod2(FileOutputStream out, int periods,
			int frequency) throws IOException {
		// 44100
		int samples = SAMPLE_RATE / frequency;
		int lowcount = samples / 2;
		int highCount = samples - lowcount;
		for (int i = 0; i < periods; i++) {

			for (int j = 0; j < lowcount; j++) {
				writeLeShort(out, (short) (MAX_LEVEL * -1));
			}
			for (int j = 0; j < highCount; j++) {
				writeLeShort(out, MAX_LEVEL);
			}
		}
	}

	private static final int BUFFER_SIZE = 65536;
	private static byte buffer[] = new byte[BUFFER_SIZE];
	private static int bufferPtr = 0;

	private static void writeLeShort(FileOutputStream out, short value)
			throws IOException {

		buffer[bufferPtr++] = (byte) (value);
		buffer[bufferPtr++] = (byte) ((value >>> 8) & 0xFF);

		if (bufferPtr == BUFFER_SIZE) {
			out.write(buffer);
			bufferPtr = 0;
			// out.write(va lue & 0xFF);
			// out.write();
		}
	}

}
