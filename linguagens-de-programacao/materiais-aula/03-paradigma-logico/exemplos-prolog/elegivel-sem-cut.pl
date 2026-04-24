elegivel(X) :- analfabeto(X), fail.
elegivel(X) :- cidadao(X),idade(X,Y), Y >= 18.
cidadao(joao).
cidadao(susana).
cidadao(roberta).
cidadao(ricardo).
cidadao(marcelo).
idade(joao, 36).
idade(susana, 15).
idade(roberta, 31).
idade(ricardo, 22).
idade(marcelo, 17).
analfabeto(joao).
