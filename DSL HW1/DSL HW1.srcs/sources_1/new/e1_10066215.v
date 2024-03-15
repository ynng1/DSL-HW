module nor_rs(q, qb, r, s);

    output q, qb;
    input r, s;

    nor #1 n1(q, r, qb);
    nor #2 n2(qb, q, s);
 
endmodule