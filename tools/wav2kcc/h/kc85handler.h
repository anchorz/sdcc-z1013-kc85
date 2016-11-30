class Kc85Handler: public Handler {
    static const int TOKEN_ZERO = 0;
    static const int TOKEN_ONE = 1;
    static const int TOKEN_SYNC = 2;

    static const int BLOCKLEN = 0x80;

    static const int SIZE_CASS_NAME = 11;
    static const int OF_CASS_AADR = 17;
    static const int OF_CASS_EADR = 19;
    static const int OF_CASS_SADR = 21;
    static const int OF_CASS_SYSTEM = 23;

    static const int CASS_SYSTEM_Z9001 = 1;
    static const int CASS_SYSTEM_KC85 = 3;

    int last_bit;

    int bit_counter;
    int data;
    int data_counter;
    int data_crc;

    int block_counter;

    char file_name[SIZE_CASS_NAME + 5]; //+".KCC"
    int len;
    int system;
private:
    void print_header();
    int handle_data_bits(int token);
    int get_token(double ns);
    const char *get_token_str(int token);
public:
    Kc85Handler() :
        last_bit(0),bit_counter(0), data(0), data_counter(0), data_crc(0), block_counter(
                    0), len(0),system(CASS_SYSTEM_KC85) {
    }

    virtual void check(double ns, int pos);
    virtual const char *get_name() const;
    virtual const char *get_comments() const;
};

