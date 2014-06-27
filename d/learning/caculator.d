enum TokenType {num, add, sub, mul, div, lp, rp}

Struct Token {
    TokenType type;
    double value;
}

// exp = num + exp | num - exp | num
//
Token [] extract_token(string exp){
}

auto caculate(string exp) {
    tokens = extract_token(exp);
    return eval(tokens);
}

void main(){
}

unittest {
    asset(caculate(" 1 + 2 ") == 3);
}
