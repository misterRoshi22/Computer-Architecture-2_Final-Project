#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
#define forn(i, n) for (ll i = 0; i < ll(n); i++)
#define form(i, n) for (ll i = 1; i <= ll(n); i++)
#define cin(a,n) forn(i,n) cin >> a[i]
#define cout(a,n) forn(i,n) cout << a[i] << ' '
#define FastIO ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0)
#define all(a) a.begin(), a.end()
#define rall(a) a.rbegin(), a.rend()
#define yes "YES"
#define no "NO"
#define yn(b) cout<<(b?yes:no)<<'\n'
#define pb push_back

const int oo = 1000000010;
const int N = 200010;


class OF3F7  {
public:
    int opcode;
    int funct3;
    int funct7;

    OF3F7() {
        this->opcode = 0;
        this->funct3 = 0;
        this->funct7 = 0;
    }

    OF3F7(int opcode, int funct3, int funct7) {
        this->opcode = opcode;
        this->funct3 = funct3;
        this->funct7 = funct7;
    }

    void set(int opcode, int funct3, int funct7) {
        this->opcode = opcode;
        this->funct3 = funct3;
        this->funct7 = funct7;
    }
};

vector<string> instructions;
vector<string> v;
map<string, char> mnemonics;
map<string, OF3F7> opcode_funct3_funct7;

void fill_mnemonics() {
    mnemonics["add"] = 'R';
    mnemonics["and"] = 'R';
    mnemonics["or"] = 'R';
    mnemonics["sll"] = 'R';
    mnemonics["slt"] = 'R';
    mnemonics["srl"] = 'R';
    mnemonics["sub"] = 'R';
    mnemonics["xor"] = 'R';

    mnemonics["addi"] = 'I';
    mnemonics["andi"] = 'I';
    mnemonics["ori"] = 'I';
    mnemonics["lb"] = 'I';
    mnemonics["lw"] = 'I';
    mnemonics["jalr"] = 'I';

    mnemonics["beq"] = 'B';
    mnemonics["bne"] = 'B';

    mnemonics["jal"] = 'J';

    mnemonics["lui"] = 'U';

    mnemonics["sb"] = 'S';
    mnemonics["sw"] = 'S';
}
void fill_OF3F7() {
    opcode_funct3_funct7["add"].set(51,6,0);
    opcode_funct3_funct7["and"].set(51,5,0);
    opcode_funct3_funct7["or"].set(51,3,0);
    opcode_funct3_funct7["sll"].set(51,2,0);
    opcode_funct3_funct7["slt"].set(51,4,0);
    opcode_funct3_funct7["srl"].set(51,0,0);
    opcode_funct3_funct7["sub"].set(51,1,20);
    opcode_funct3_funct7["xor"].set(51,7,0);

    opcode_funct3_funct7["addi"].set(27,0,0);
    opcode_funct3_funct7["andi"].set(19,6,0);
    opcode_funct3_funct7["ori"].set(19,7,0);
    opcode_funct3_funct7["lb"].set(03,2,0);
    opcode_funct3_funct7["lw"].set(03,0,0);
    opcode_funct3_funct7["jalr"].set(103,0,0);

    opcode_funct3_funct7["beq"].set(99,1,0);
    opcode_funct3_funct7["bne"].set(99,0,0);

    opcode_funct3_funct7["jal"].set(111,0,0);

    opcode_funct3_funct7["lui"].set(56,0,0);;

    opcode_funct3_funct7["sb"].set(35,2,0);
    opcode_funct3_funct7["sw"].set(35,0,0);

}
int register_number(string r) {
    if(r == "zero") return 0;
    if(r == "ra") return 1;
    if(r == "sp") return 2;
    if(r == "gp") return 3;
    if(r == "tp") return 4;
    if(r == "t0") return 5;
    if(r == "t1") return 6;
    if(r == "t2") return 7;
    if(r == "s0") return 8;
    if(r == "s1") return 9;
    if(r == "a0") return 10;
    if(r == "a1") return 11;
    if(r == "a2") return 12;
    if(r == "a3") return 13;
    if(r == "a4") return 14;
    if(r == "a5") return 15;
    if(r == "a6") return 16;
    if(r == "a7") return 17;
    if(r == "s2") return 18;
    if(r == "s3") return 19;
    if(r == "s4") return 20;
    if(r == "s5") return 21;
    if(r == "s6") return 22;
    if(r == "s7") return 23;
    if(r == "s8") return 24;
    if(r == "s9") return 25;
    if(r == "s10") return 26;
    if(r == "s11") return 27;
    if(r == "t3") return 28;
    if(r == "t4") return 29;
    if(r == "t5") return 30;
    if(r == "t6") return 31;
    if(r == "fp") return 8;

    if(r == "x0") return 0;
    if(r == "x1") return 1;
    if(r == "x2") return 2;
    if(r == "x3") return 3;
    if(r == "x4") return 4;
    if(r == "x5") return 5;
    if(r == "x6") return 6;
    if(r == "x7") return 7;
    if(r == "x8") return 8;
    if(r == "x9") return 9;
    if(r == "x10") return 10;
    if(r == "x11") return 11;
    if(r == "x12") return 12;
    if(r == "x13") return 13;
    if(r == "x14") return 14;
    if(r == "x15") return 15;
    if(r == "x16") return 16;
    if(r == "x17") return 17;
    if(r == "x18") return 18;
    if(r == "x19") return 19;
    if(r == "x20") return 20;
    if(r == "x21") return 21;
    if(r == "x22") return 22;
    if(r == "x23") return 23;
    if(r == "x24") return 24;
    if(r == "x25") return 25;
    if(r == "x26") return 26;
    if(r == "x27") return 27;
    if(r == "x28") return 28;
    if(r == "x29") return 29;
    if(r == "x30") return 30;
    if(r == "x31") return 31;
    return -1;






}
string to_binary(int n, int bits) {

    if(n < 0) {
        n = -n;
        string s = "";
        while(n) {
            s += (n%2) + '0';
            n /= 2;
        }
        while(s.size() < bits) s += '0';
        reverse(s.begin(), s.end());
        for(int i = 0; i < s.size(); i++) {
            if(s[i] == '0') s[i] = '1';
            else s[i] = '0';
        }
        int carry = 1;
        for(int i = s.size() - 1; i >= 0; i--) {
            if(s[i] == '0' && carry == 1) {
                s[i] = '1';
                carry = 0;
            }
            else if(s[i] == '1' && carry == 1) {
                s[i] = '0';
                carry = 1;
            }
        }
        return s;
    }


    string s = "";
    while(n) {
        s += (n%2) + '0';
        n /= 2;
    }
    while(s.size() < bits) s += '0';
    reverse(s.begin(), s.end());
    return s;
}
string bin_to_hex(string s) {
    string ans = "";
    int i = 0;
    while(i < s.size()) {
        int n = 0;
        int j = 0;
        while(j < 4) {
            n = n*2 + (s[i] - '0');
            i++;
            j++;
        }
        if(n < 10) ans += (n + '0');
        else ans += (n - 10 + 'a');
    }
    return ans;
}


void print_IM(int start) {

    cout << "module instruction_memory(clk, address, read_data);\n" << endl;

    cout << "input clk;\n input [14:0] address;\n output reg [31:0] read_data;\n" << endl;
    cout << "reg [7:0] memory[0:32767];\n";
    cout << "initial begin\n" << endl;





    //round down to nearest multiple of 4
    start = start/4 * 4;
    //i want to print the instruction in this format such that each
    // instruction takes up 4 bytes of memory and its little endian
//    memory[0] = 8'h1B;
//    memory[1] = 8'h03;
//    memory[2] = 8'h40;
//    memory[3] = 8'h03;

    for(int i  = 0; i < instructions.size(); i++) {
        string s = instructions[i];
        string vs = v[i];

       for(int j = 7; j >=0; j-=2){
           cout << "\t\tmemory[" << start + 3 - j/2 << "] = 8'h" << s[j-1] << s[j] << ";";
           if(j == 7) cout <<"    " << '/' << '/' << vs << endl;
              else cout << endl;
       }
       cout << endl;
       start += 4;

    }
    cout << "end\n" << "wire [14:0] add0, add1, add2, add3;\n" << endl;

    cout << "assign add0 = (address & 15'h7ffc) + 15'd0;\n";
    cout << "assign add1 = (address & 15'h7ffc) + 15'd1;\n";
    cout << "assign add2 = (address & 15'h7ffc) + 15'd2;\n";
    cout << "assign add3 = (address & 15'h7ffc) + 15'd3;\n";


    cout << "always @(negedge clk) begin //reading done at negative edges\n";
    cout << "\tread_data <= {memory[add3], memory[add2], memory[add1], memory[add0]};\n";
    cout << "end\n" << endl;

    cout << "endmodule // instruction_memory\n" << endl;
}
void R_type(string instruction) {
    vector<string> tokens;
    //v[0] = mnemonic, v[1] = rd, v[2] = rs1, v[3] = rs2
    int i = 0;
    while(i < instruction.size()) {
        string temp = "";
        while(i < instruction.size() && instruction[i] != ' ') {
            temp += instruction[i];
            i++;
        }
        tokens.push_back(temp);
        i++;
    }

    //get the opcode, funct3 and funct7
    OF3F7 of3f7 = opcode_funct3_funct7[tokens[0]];
    int opcode = of3f7.opcode;
    int funct3 = of3f7.funct3;
    int funct7 = of3f7.funct7;
    int rd = register_number(tokens[1]);
    int rs1 = register_number(tokens[2]);
    int rs2 = register_number(tokens[3]);

    //get the binary representation of the instruction
    string binary = "";
    binary += to_binary(funct7,7);
    binary += to_binary(rs2,5);
    binary += to_binary(rs1,5);
    binary += to_binary(funct3,3);
    binary += to_binary(rd,5);
    binary += to_binary(opcode,7);

    //convert binary to hex
    string hex = bin_to_hex(binary);
    instructions.push_back(hex);
}
void I_type(string instruction) { //for addi ori andi
    vector<string> tokens;
    //v[0] = mnemonic, v[1] = rd, v[2] = rs1, v[3] = imm
    int i = 0;
    while(i < instruction.size()) {
        string temp = "";
        while(i < instruction.size() && instruction[i] != ' ') {
            temp += instruction[i];
            i++;
        }
        tokens.push_back(temp);
        i++;
    }

    //get the opcode, funct3 and funct7
    OF3F7 of3f7 = opcode_funct3_funct7[tokens[0]];
    int opcode = of3f7.opcode;
    int funct3 = of3f7.funct3;
    int funct7 = of3f7.funct7;
    int rd = register_number(tokens[1]);
    int rs1 = register_number(tokens[2]);
    int imm = stoi(tokens[3]);

    //print for debugging
    //cout << opcode << ' ' << funct3 << ' ' << funct7 << ' ' << rd << ' ' << rs1 << ' ' << imm << endl;

    //get the binary representation of the instruction
    string binary = "";
    binary += to_binary(imm,12);
    binary += to_binary(rs1,5);
    binary += to_binary(funct3,3);
    binary += to_binary(rd,5);
    binary += to_binary(opcode,7);

    //convert binary to hex
    string hex = bin_to_hex(binary);
    instructions.push_back(hex);

}
void U_type(string instruction) { //for lui
    vector<string> tokens;
    //v[0] = mnemonic, v[1] = rd, v[2] = imm
    int i = 0;
    while(i < instruction.size()) {
        string temp = "";
        while(i < instruction.size() && instruction[i] != ' ') {
            temp += instruction[i];
            i++;
        }
        tokens.push_back(temp);
        i++;
    }

    //get the opcode, funct3 and funct7
    OF3F7 of3f7 = opcode_funct3_funct7[tokens[0]];
    int opcode = of3f7.opcode;
    int rd = register_number(tokens[1]);
    int imm = stoi(tokens[2]);

    //get the binary representation of the instruction
    string binary = "";
    binary += to_binary(imm,20);
    binary += to_binary(rd,5);
    binary += to_binary(opcode,7);

    //convert binary to hex
    string hex = bin_to_hex(binary);
    instructions.push_back(hex);

}
void L_type(string instruction) { //lw t1 100 t2
    vector<string> tokens;
    //v[0] = mnemonic, v[1] = rd, v[2] = imm, v[3] = rs1
    int i = 0;
    while(i < instruction.size()) {
        string temp = "";
        while(i < instruction.size() && instruction[i] != ' ') {
            temp += instruction[i];
            i++;
        }
        tokens.push_back(temp);
        i++;
    }

    //get the opcode, funct3 and funct7
    OF3F7 of3f7 = opcode_funct3_funct7[tokens[0]];
    int opcode = of3f7.opcode;
    int funct3 = of3f7.funct3;
    int rd = register_number(tokens[1]);
    int rs1 = register_number(tokens[3]);
    int imm = stoi(tokens[2]);

    //get the binary representation of the instruction
    string binary = "";
    binary += to_binary(imm,12);
    binary += to_binary(rs1,5);
    binary += to_binary(funct3,3);
    binary += to_binary(rd,5);
    binary += to_binary(opcode,7);

    //convert binary to hex
    string hex = bin_to_hex(binary);
    instructions.push_back(hex);
}
void S_type(string instruction) { // sd t1 -100 t2
    vector<string> tokens;
    //v[0] = mnemonic, v[1] = rs2, v[2] = imm, v[3] = rs1
    int i = 0;
    while(i < instruction.size()) {
        string temp = "";
        while(i < instruction.size() && instruction[i] != ' ') {
            temp += instruction[i];
            i++;
        }
        tokens.push_back(temp);
        i++;
    }

    //get the opcode, funct3 and funct7
    OF3F7 of3f7 = opcode_funct3_funct7[tokens[0]];
    int opcode = of3f7.opcode;
    int funct3 = of3f7.funct3;
    int rs2 = register_number(tokens[1]);
    int rs1 = register_number(tokens[3]);
    int imm = stoi(tokens[2]);

    //get the binary representation of the instruction
    string binary = "";
    //get immediate then seperate it into 2 parts imm1 = imm[11:5] and imm2 = imm[4:0]
    string imm_binary = to_binary(imm,12);
    string imm1 = imm_binary.substr(0,7);
    string imm2 = imm_binary.substr(7,5);
    binary += imm1;
    binary += to_binary(rs2,5);
    binary += to_binary(rs1,5);
    binary += to_binary(funct3,3);
    binary += imm2;
    binary += to_binary(opcode,7);

    //convert binary to hex
    string hex = bin_to_hex(binary);
    instructions.push_back(hex);
}
void B_type(string instruction) { //beq t1 t2 100
    vector<string> tokens;
    //v[0] = mnemonic, v[1] = rs1, v[2] = rs2, v[3] = imm
    int i = 0;
    while(i < instruction.size()) {
        string temp = "";
        while(i < instruction.size() && instruction[i] != ' ') {
            temp += instruction[i];
            i++;
        }
        tokens.push_back(temp);
        i++;
    }

    //get the opcode, funct3 and funct7
    OF3F7 of3f7 = opcode_funct3_funct7[tokens[0]];
    int opcode = of3f7.opcode;
    int funct3 = of3f7.funct3;
    int rs1 = register_number(tokens[1]);
    int rs2 = register_number(tokens[2]);
    int imm = stoi(tokens[3]);

    //get the binary representation of the instruction
    string binary = "";
    //get immediate then seperate it into 2 parts imm1 = imm[12] and imm2 = imm[10:5] and imm3 = imm[4:1] and imm4 = imm[11]
    string imm_binary = to_binary(imm,13);
    string imm1 = imm_binary.substr(0,1);
    string imm2 = imm_binary.substr(2,6);
    string imm3 = imm_binary.substr(8,4);
    string imm4 = imm_binary.substr(1,1);
    binary += imm1;
    binary += imm2;
    binary += to_binary(rs2,5);
    binary += to_binary(rs1,5);
    binary += to_binary(funct3,3);
    binary += imm3;
    binary += imm4;
    binary += to_binary(opcode,7);

    //convert binary to hex
    string hex = bin_to_hex(binary);
    instructions.push_back(hex);
}
void J_type(string instruction) { // jal r1 1000
    vector<string> tokens;
    //v[0] = mnemonic, v[1] = rd, v[2] = imm
    int i = 0;
    while(i < instruction.size()) {
        string temp = "";
        while(i < instruction.size() && instruction[i] != ' ') {
            temp += instruction[i];
            i++;
        }
        tokens.push_back(temp);
        i++;
    }

    //get the opcode, funct3 and funct7
    OF3F7 of3f7 = opcode_funct3_funct7[tokens[0]];
    int opcode = of3f7.opcode;
    int rd = register_number(tokens[1]);
    int imm = stoi(tokens[2]);

    //get the binary representation of the instruction
    string binary = "";
    //get immediate then seperate it into 4 parts imm1 = imm[20] and imm2 = imm[10:1] and imm3 = imm[11] and imm4 = imm[19:12]
    string imm_binary = to_binary(imm,21);
    string imm1 = imm_binary.substr(0,1);
    string imm2 = imm_binary.substr(10,10);
    string imm3 = imm_binary.substr(9,1);
    string imm4 = imm_binary.substr(1,8);
    binary += imm1;
    binary += imm2;
    binary += imm3;
    binary += imm4;
    binary += to_binary(rd,5);
    binary += to_binary(opcode,7);

    //convert binary to hex
    string hex = bin_to_hex(binary);
    instructions.push_back(hex);
}
void jalr_type(string instruction) {
    vector<string> tokens;
    //v[0] = mnemonic, v[1] = rd, v[2] = imm, v[3] = rs1
    int i = 0;
    while(i < instruction.size()) {
        string temp = "";
        while(i < instruction.size() && instruction[i] != ' ') {
            temp += instruction[i];
            i++;
        }
        tokens.push_back(temp);
        i++;
    }
    //same format as I type

    //get the opcode, funct3 and funct7
    OF3F7 of3f7 = opcode_funct3_funct7[tokens[0]];
    int opcode = of3f7.opcode;
    int funct3 = of3f7.funct3;
    int rd = register_number(tokens[1]);
    int rs1 = register_number(tokens[3]);
    int imm = stoi(tokens[2]);

    //get the binary representation of the instruction
    string binary = "";
    //imm1 = imm[11:0]
    string imm_binary = to_binary(imm,12);
    string imm1 = imm_binary.substr(0,12);
    binary += imm1;
    binary += to_binary(rs1,5);
    binary += to_binary(funct3,3);
    binary += to_binary(rd,5);
    binary += to_binary(opcode,7);

    //convert binary to hex
    string hex = bin_to_hex(binary);
    instructions.push_back(hex);
}


string clean(string s) {
    string temp = "";
    for(int i = 0; i < s.size(); i++) {
        if(s[i] == ')' || s[i] == '(') temp += ' ';
        else if(s[i] != ',' && s[i] != ';') temp += s[i];
    }
   // cout << temp << endl;
    return temp;
}


void solve(){

    fill_mnemonics();
    fill_OF3F7();
    string x;

   // cout << to_binary(-12,13)   << endl;
    //read lines
    while(getline(cin,x)) {
        v.push_back(clean(x));
    }

    for(int i = 0; i < v.size(); i++) {
        // get mnemonic so that we can know if its R type or I type
        string m = "";
        int j = 0;
        while(j < v[i].size() && v[i][j] != ' ') {
            m += v[i][j];
            j++;
        }
        if(mnemonics[m] == 'R') R_type(v[i]);
        else if (mnemonics[m] == 'I' && m != "lb" && m!= "lw" && m!= "jalr") I_type(v[i]);
        else if (m == "jalr") jalr_type(v[i]);
        else if (m == "lb" || m == "lw") L_type(v[i]);
        else if (mnemonics[m] == 'U') U_type(v[i]);
        else if (mnemonics[m] == 'S') S_type(v[i]);
        else if (mnemonics[m] == 'B') B_type(v[i]);
        else if (mnemonics[m] == 'J') J_type(v[i]);
        else if (m == "nop") {
            string instruction = "add zero zero zero";
            R_type(instruction);
        }

    }

    for(int i = 0; i < instructions.size(); i++) {
        //cout << i <<": "  << instructions[i] << endl;
    }

    print_IM(0);


}


int main(void) {

    FastIO;
#ifndef ONLINE_JUDGE
    freopen("input.text.txt", "r", stdin);
    freopen("output.txt.txt","w",stdout);
#endif
    int t = 1;
    //cin >> t;
    while (t--) {
        solve();
    }
    return 0;
}
