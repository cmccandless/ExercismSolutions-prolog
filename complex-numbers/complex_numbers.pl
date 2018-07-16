real((R, _), X):- R=X. 
imaginary((_, I), X):- I=X.

conjugate((R, I), (X, Y)):- X is R, Y is -I.
abs((R, I), X):- X = sqrt(R * R + I * I).

add((A, B), (C, D), (X, Y)):- X is (A + C), Y is (B + D).
sub((A, B), (C, D), (X, Y)):- X is (A - C), Y is (B - D).

mul((A, B), (C, D), (X, Y)):- X is (A * C - B * D), Y is (A * D + B * C).
div((A, B), (C, D), (X, Y)):- 
    X is ((A * C + B * D) / (C * C + D * D)),
    Y is ((B * C - A * D) / (C * C + D * D)).
