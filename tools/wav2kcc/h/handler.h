#define STATE_UNKNOWN 0
#define STATE_WAIT_FOR_SYNC 1
#define STATE_WAIT_2ND_SYNC 2
#define STATE_SAMPLE_DATA   3
#define STATE_ABORT   4

class Handler {
    unsigned char buffer[65536];
    int size;
protected:
    int state;
    int save_ok;

    void append(unsigned char);
    unsigned char read_byte(int offset);
    unsigned short read_word(int offset);
    void write_word(int offset, unsigned short data);
    void write_image(const char *name);
public:
    Handler() :
            size(0), state(STATE_UNKNOWN), save_ok(0) {
    }

    virtual ~Handler() {
    }

    const char *get_state_str();
    virtual void check(double ns, int pos)=0;
    virtual const char *get_name() const =0;
    virtual const char *get_comments() const =0;
};

