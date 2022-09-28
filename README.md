# FODE
Numerical methods for solving Fractional Ordinary Differential Equation(FODE)


# Computational Mathematical Science Lab

Advisor : [Bongsu Jang](https://research.unist.ac.kr/post-research/24645-2/)

period : 2020 Winter

# 1. Theoretical Background

## 1.1 Interpolation

### 1.1.1 Theorem

Suppose t$f$ is defined and continuous on [a, b]. For each ε > 0, there exists a polynomial $P(x)$, with the property that

$$
|f(x)-P(x)|<\epsilon, \text{ for all } x \text{ in } [a,b]
$$

### 1.1.2 Definition

Define the functions

$$
L_0(x)=\frac{x-x_1}{x_0-x_1} \text{ and } L_1(x) = \frac{x-x_0}{x_1-x_0}
$$

The linear **Lagrange interpolating polynomial** through $(x_0,y_0)$ and $(x_1,y_1)$ is 

$$
P(x) = L_0(x)f(x_0)+L_1(x)f(x_1)
$$

### 1.1.3 Theorem

 If $x_0,x_1, \cdots,x_n$ are n + 1 distinct numbers and $f$ is a function whose values are given at these numbers, then a unique polynomial $P(x)$  of degree at most n exists with

$$
f(x_k)=P(x_k),\text{ for each }k=0,1,\cdots n.
$$

This polynomial is given by

$$
P(x)=f(x_0)L_{n,0}(x)+\cdots +f(x_n)L_{n,n}(x)=\sum_{k=0}^nf(x_k)L_{n,k}(x)
$$

where, for each $k=0,1,\dots , n,$

## 1.2 Fractional Calculus

### 1.2.1 Definition

Gamma function $\Gamma : (0,\infty) \rightarrow \mathbb{R}$, defined by

$$
\Gamma(x) := \int_0^\infty t^{x-1}e^{-t}dt
$$

is called Euler’s Gamma function.

### 1.2.2 Definition

Let $\alpha \in \mathbb{R}_+$. The operator $^{RL}J_a^\alpha$, defined on $L_1[a,b]$  by

$$
^{RL}J_a^\alpha :=\frac{1}{\Gamma(\alpha)}\int_a^x(x-t)^{\alpha-1}f(t)dt
$$

for $a\leq x \leq b$, is called the Riemann-Liouville fractional integral operator of order $\alpha$.

### 1.2.3 Definition

Let $n\in\mathbb{R}_+$, and $m=\lceil \alpha \rceil$. The operator $^{RL}D_a^\alpha$, defined by
}

$$
^{RL}D_a^\alpha := ^{RL}D^m {}^{RL} J_a^{m-\alpha}f
$$

is called the Riemann-Liouville fractional differential operator of order $\alpha$.

### 1.2.4 Lemma

Let $\alpha>0$, $\alpha \in \mathbb{N}$, and $m=\lceil\alpha\rceil$. Assume that $f\in\mathbb{C}^m[a,b]$. Then,

$$
^{RL}D_a^\alpha f(x)=\frac{1}{\Gamma(-\alpha)}\int_a^x(x-t)^{-\alpha - 1}f(t)dt
$$

With a = 0

$$
^{RL}D_0^\alpha f(x)=\frac{1}{\Gamma(1-\alpha)}\frac{d}{dx}\int_0^x(x-t)^{-\alpha}f(t)dt
$$

### 1.2.5 Definition

Let $\alpha > 0$, $\alpha \in \mathbb{N}$, and . Assume that . Then,

$$
^{C}D_a^\alpha f(x)=\frac{1}{\Gamma(n-\alpha)}\int_a^x\frac{f^{(n)}(t)}{(x-t)^{(\alpha+1-n)}}dt
$$

With a = 0, n=1

$$
^{C}D_0^\alpha f(x)=\frac{1}{\Gamma(1-\alpha)}\int_0^x(x-t)^{-\alpha}f'(t)dt
$$

# 2 Solving ODEs in terms of Riemann- Liouville

## 2.1 Predictor-Corrector(PECE) Method and Higher-Order Method

We need to solve the ordinary differential equation and the equation is given as

$$
\begin{cases} D_a^\alpha y(t) =f(t,y(t))& t\in[a,b] \\
 y^{(k)}(0)=y_k&k=0,1,\cdots,[\alpha] \end{cases}
$$

### 2.1.1 Lemma

Consider the ordinary differential equation above. Let $\alpha > 0$. The function $y\in C[a,b]$  is a solution of the initial value proble if and only if it is a solution of the nonlinear Volterra integral equation of the second kind.

$$
y(t) = \sum_{k=0}^{[\alpha]}\frac{(x-a)^k}{k!}y_k + \frac{1}{\Gamma(\alpha)}\int_a^t(t-\tau)^{(\alpha -1)}f(\tau,y(\tau))d\tau
$$

### 2.1.2 Numerical Scheme

We will use ’Predictor-Corrector Method’ as a numerical scheme to solve given ordinary differential equation. The method approximates the solution and the approximation consists of two parts: ’predictor’ part and ’corrector part’. Predictor is the part which predicts the solution by using initial values and Corrector part corrects predictor values.
Before we use the method, we make the assumption that the domain consists of finitely many values and that the interval is uniform. Let $\Phi_N$ be the domain, then

$$
\Phi_{N} =\{ t_j | a = t_0 < \cdots < t_j < \cdots < t_n < t_{n+1} < \cdots < t_N = b \}
$$

and $t_j-t_{j-1} =h$ for $j=1,\dots,N$, where $h=\frac{b-a}{N}$. And we will denote $f(t_j,y_j)$ as $f_j$ and $y_j$ as the approximated value of $y(t_j)$, which is the exact value.

By the lemma 2.11, we can approximate $y_{n+1}$ by

$$
y(t_{n+1})\simeq y_{n+1} = g(t_{n+1})+\frac{1}{\Gamma(\alpha)}\sum_{j=0}^n\int_{t_j}^{t_{j+1}}(t_{n+1}-\tau)^{\alpha-1}f(\tau,y(\tau))d\tau
$$

where 

$$
g(t_{n+1}) = \sum_{k=0}^{[\alpha]} \frac{(t_{n+1}-a)^k}{k!}y^{(k)}
$$

We will substitute $f(\tau,y(\tau))$ by interpolating previous points. For the case n = 0, the equation above becomes

$$
y(t_{1})= g(t_{1})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1}}(t_{1}-\tau)^{\alpha-1}f(\tau,y(\tau))d\tau
$$

and we only have the information about $y_0$ term, which is the initial value. So we interpolate $f(\tau,y(\tau))$ by $f_0$. And then,

$$
y(t_{1})\simeq y_1= g(t_{1})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1}}(t_{1}-\tau)^{\alpha-1}f_0d\tau
$$

If $n \geq 1$ we need to consider $f(\tau,y(\tau))$ with regard to $j$. For the case of $j\neq n$, we substitute the term $f(\tau,y(\tau))$ by

$$
f(\tau,y(\tau))\simeq\frac{\tau-t_j}{-h}f_{j-1}+\frac{\tau-t_{j-1}}{h}f_j
$$

for $1\leq j \leq n-1$.

If $j=n$, we can’t interpolate the term as we have interpolated in the case of $j\neq n$, since we don’t have information about $f_{j+1}$. For solving this problem, we have two methods: Higher Order Method, PECE Method.

By using PECE Method, we just substitute $f(\tau,y(\tau))$ on so that

$$
f(\tau,y(\tau))\simeq f_n
$$

on $I_n = [t_n,t_{n+1}].$

And the convergence analysis shows that error is expected to be

$$
\max_{j=1,\dots,n}|y(t_j)-y_j|=O(h^q)
$$

where $q = \min(2,1+\alpha)$.

By using Second Order Method, higher order method of order 2, $f(\tau,y(\tau))$ by interpolating two terms, $f_{n-1},f_n$ i.e.

$$
f(\tau,y(\tau))\simeq\frac{\tau-t_n}{-h}f_{n-1}+\frac{\tau-t_{n-1}}{h}f_n
$$

on $I_n=[t_n,t_{n+1}]$.

As we know intuitively, $\min(2,1+\alpha)\leq2$ since $0<\alpha<1$. It means that the approximated value converges to the exact values faster if we use Second Order Method.

### 2.1.3 Theorem

Let define $E_{n+1}$ is global error. Suppose $f(\cdot,y(\cdot))\in C^2[a,b]$ and is Lipschitz continuous, i.e. 

$$
|f(x,y_1)-f(x,y_2)|\leq L|y_1-y_2|
$$

for some $L>0$. Then we have

$$
E_{n+1} = |y(t_{n+1})-y_{n+1}|\leq O(h^2)
$$

where $y_{n+1}$ is approximated value and $y(t_{n+1})$ is exact value for $t=t_{n+1}$.

### 2.1.4 Example

We will solve the ordinary differential equation given below

$$
\begin{cases}D_0^\alpha y(t)=\frac{\Gamma(4+\alpha)}{6}t^3+t^{3+\alpha}-y \\ 
y^{(0)}=0,y^{(1)}(0)=0 \end{cases}
$$

and the exact solution for the equation is

$$
y(t)=t^{3+\alpha}
$$

By using two methods, Second Order Method and PECE Method, we need to check the convergence rates.

We divide the interval $[0,1]$ by $2 \times 10^{i-1}$ times where $i$ signifies the number of iterations.

$$
N(i) = 2 \times10^{i-1}
$$

We measure the convergence rates $C_1,C_2,C_3$ by using 3 norms, $E_1,E_2,E_3$ for each iterations by

$$
E_1 = |y(t_N)-y_N| \\ E_2 = \max_{j=0,\dots N}|y(t_j)-y_j| \\ E_3= \sqrt{h\sum_{j=0}^N|y(t_j)-y_j|}
$$

$$
C_j(i) = \log_2 \frac{E_j(N(i))}{E_j(N(i+1))} \text{  , j=1,2,3}
$$

We need to check whether convergence rate for PECE method approximates to $\min(1+\alpha,2)$ and convergence rate for Second Order Method approximates to 2.


## 2.2 Second Order PECE Method

### 2.3.1 Lemma

Assume that $\phi \in\mathbb{P}_1[0,T]$  where $\mathbb{P}_1$ is the space of all polynomials of degree less than or equal to one. Let
$\phi_n, \text{ } n=0,\dots,N$ be all the restricted value of $\phi(t)$ on grid $\Phi_N$ . Then, there exists coefficients $b_{n+1}^0$ and $b_{n+1}^1$ such that the following equality

$$
\int_{t_n}^{t_{n+1}}(t_{n+1}-\tau)^{\alpha-1}\phi(\tau)d\tau =\frac{h^\alpha}{\alpha(\alpha+1)}(b_{n+1}^0\phi_{n-1}+b_{n-1}^1\phi_n)
$$

is exact. More precisely

$$
b_{n+1}^0=-1, b_{n+1}^1=\alpha+2
$$

Lemma is proved by interpolating $\phi_{n-1}$ and $\phi_n$. i.e.

$$
\phi(\tau)\simeq\frac{\tau-t_{n-1}}{h}\phi_n+\frac{\tau-t_n}{-h}\phi_{n-1}
$$

By using the Lemma, we will construct ’Second Order PECE Method’.

First, we predict $y_{n+1}^P$ by using second order method.

$$
\tilde{y}_{n+1}^P=g_{n+1}+\tilde{y}_{n+1}^*+\frac{h^\alpha}{\Gamma(\alpha+2)}[b_{n+1}^0\tilde{f}_{n-1}+b_{n+1}^1\tilde{f}_{n}]
$$

And then, we use the points $f_0,\dots,f_n=f(t_n,y_n), f_{n+1}^P=f(t_{n+1},y_{n+1}^P)$ and substitute $f(\tau)$ by interpolating starting point and ending point of each interval $I_j=[t_j,t_{j+1}]$ for $j=0,\dots,n.$

$$
\tilde{y}_{n+1}=g_{n+1}+\tilde{y}_{n+1}^*+\tilde{Y}_{n+1}
$$

where

$$
\tilde{y}_{n+1}^*=\frac{1}{\Gamma(\alpha)}\sum_{j=0}^{n-1}\int_{t_j}^{t_{j+1}}(t_{n+1}-\tau)^{\alpha-1}(\frac{\tau-t_j}{h}f_{j+1}+\frac{\tau-t_{j+1}}{-h}f_{j})
$$

and

$$
\tilde{Y}_{n+1}=\frac{1}{\Gamma(\alpha)}\int_{t_n}^{t_{n+1}}(t_{n+1}-\tau)^{\alpha-1}(\frac{\tau-t_n}{h}f_{n+1}+\frac{\tau-t_{n+1}}{-h}f_{n})
$$

### 2.3.2 Example

We will solve the ordinary differential equation on the previous example by using second order predictor corrector method.



## 2.4 Quadratic PECE Method

### 2.4.1 Theorem

Suppose that $f(\cdot,u(\cdot))\in C^3[0,T]$, and is Lipschitz continuous, then the $E_{n+1}\leq Ch^3$
given $E_1,E_2 \leq Ch^3$ and  $E_{1/2}\leq\begin{cases}Ch^{3-\alpha}&(0<\alpha<1)\\Ch^2&(\alpha>1)\end{cases}$

### 2.4.2 Lemma

Assume that $\phi(t)\in\mathbb{P}_2[0,T]$  where $\mathbb{P}_2$ is the space of all polynomials of degree less than or equal to two. Let $\phi_n,n-1,\dots,N$ be the restricted value of $\phi(t)$ on grid $\Phi_N$. Then, there exists coefficient $a_0^{n+1},a_1^{n+1},a_2^{n+1}$ such that the following equality

$$
\int_{t_n}^{t_{n+1}}(t_{n+1}-\tau)\phi(\tau)d\tau = A(a_{n+1}^0\phi_{n-2}+a_{n+1}^1\phi_{n-1}+a_{n+1}^2\phi_{n})
$$

is exact, where $A=\frac{h^\alpha}{\alpha(\alpha+1)(\alpha+2)}, a_{n+1}^0=\frac{\alpha+4}{2},a_{n+1}^1 = -2(\alpha+3)$ and $a_{n+1}^2=\frac{2\alpha^2+9\alpha+12}{2}$. We also can prove this lemma by substituting $\phi(\tau)$ by interpolation of $\phi_{n-2},\phi_{n-1}$and $\phi_n$. i.e.

$$
\phi(\tau)=\frac{(\tau-t_{n-1})(\tau-t_n)}{(t_{n-2}-t_{n-1})(t_{n-2}-t_n)}\phi_{n-2}+\frac{(\tau-t_{n-2})(\tau-t_n)}{(t_{n-1}-t_{n-2})(t_{n-1}-t_n)}\phi_{n-1}+\frac{(\tau-t_{n-2})(\tau-t_{n-1})}{(t_{n}-t_{n-2})(t_{n}-t_{n-1})}\phi_{n}
$$

### 2.4.3 Numerical Scheme

We need to predict $t_{1/4},4_{1/2}$ to predict the point $y_1$. Denote $L(a,b)$ be the linear interpolation of $a$ and $b$ and $Q(a,b,c)$ be the Quadratic interpolation of $a,b$ and $c$. And denote $f(t_j,y_j)$ as $f_j$, $f(t_j,y_j^P)$ as $f_j^P$, and $f(t_j,y_j^{PP})$  as $f_j^{PP}$

$$
y_{1/4}^P=g(t_{1/4})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1/4}}(t_{1/4}-\tau)^{\alpha-1}f_0d\tau
$$

$$
y_{1/4}=g(t_{1/4})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1/4}}(t_{1/4}-\tau)^{\alpha-1}L(f_0,f_{1/4}^P)d\tau
$$

$$
y_{1/2}^{PP}=g(t_{1/2})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1/2}}(t_{1/2}-\tau)^{\alpha-1}f_{1/4}d\tau
$$

$$
y_{1/2}^P=g(t_{1/2})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1/2}}(t_{1/2}-\tau)^{\alpha-1}L(f_{1/4},f_{1/2}^{PP})d\tau
$$

$$
y_{1/2}=g(t_{1/2})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1/2}}(t_{1/2}-\tau)^{\alpha-1}Q(f_0,f_{1/4},f_{1/2}^P)d\tau
$$

$$
y_{1}^{PP}=g(t_{1})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1}}(t_{1}-\tau)^{\alpha-1}f_{1/2}d\tau
$$

$$
y_{1}^P=g(t_{1})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1}}(t_{1}-\tau)^{\alpha-1}L(f_{1/2},f_1^{PP})d\tau
$$

$$
y_{1}=g(t_{1})+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_{1}}(t_{1}-\tau)^{\alpha-1}Q(f_{1/4},f_{1/2},f_{1}^P)d\tau
$$

where $g(t)=\sum_{k=0}^my_k\frac{t^k}{k!}$. And then, we can predict $y_j$ terms for $j=2,\dots,N$ using predictor term $y_j^P$ and predictor predictor term $y_j^{PP}$

$$
y_j^{PP}=g(t_j)+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_j}(t_j-\tau)^{\alpha-1}f_{j-1}d\tau
$$

$$
y_j^{P}=g(t_j)+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_j}(t_j-\tau)^{\alpha-1}L(f_{j-1},f_j^{PP})d\tau
$$

$$
y_j=g(t_j)+\frac{1}{\Gamma(\alpha)}\int_{t_0}^{t_j}(t_j-\tau)^{\alpha-1}Q(f_{j-2},f_{j-1},f_j^{P})d\tau
$$

### 2.4.4 Example

We solve the same example and we need to check whether its convergence rate approximates to 3. We do not consider convergence rate $C_2$ of the error $E_2$,since the error is biggest at $t=t_{1/4}$$j=0,\dots,N$. We have to observe that the convergence rate approximates to 3.



# 3. Solving ODEs in terms of Caputo Fabrizio operator

## 3.1 Classical PECE

As same as the PECE for Riemann Liouville operator, we use the $\hat{g}_{n+1}$ as the predictor and 
$\frac{1-\alpha}{M(\alpha)}f(t_{n+1},y(t_{n+1}))$ is the corrector.

$$
y_{n+1}=\hat{g}_{n+1}+\frac{\alpha}{1-\alpha}\sum_{j=0}^n\int_{t_j}^{t_{j+1}}e^{-\frac{\alpha}{1-\alpha}}y(\tau)d\tau
$$

where $\hat{f}_{n+1}=\frac{1-\alpha}{M(\alpha)}f(t_{n+1},y(t_{n+1}))$ and $M(\alpha)$ is normalized function, $M(0)=M(1)=1$. We assumed $M(\alpha)=1$ for simplicity. For the corrector part, we should substitute $f(\tau,y(\tau))$ by interpolation. For predictor part $g_{n+1}$, we substituted $f (t_{n+1})$ by interpolating $y_n$ and $y_{n−1}$. i.e.

$$
y_{n+1} \simeq2y_n-y_{n-1}
$$

so that

$$
y_{n+1} =f(t_{n+1},y_{n+1})\simeq f(t_{n+1},2y_n-y_{n-1})
$$

For the corrector part, we will approximate the value as we interpolated in the Riemann-Liouville case.

## 3.2 Fast Method

Calculating $y_{n+1}$ using PECE Method takes time since we have to interpolate $y(\tau)$ in all the intervals and calculate corresponding values of$\int_{t_j}^{t_{j+1}}e^{-\frac{\alpha}{1-\alpha}(t_{j+1}-\tau)}y(\tau)d\tau$ for all j, so that it takes more time as n increases. Fast Method is devised to decrease this kind of cost.

$$
f(t_{n+1})=\hat{g}_{n+1}+\frac{\alpha}{1-\alpha}H_{n+1}
$$

where $H_j = \int_{t_0}^{t_j}e^{-\frac{\alpha}{1-\alpha}(t_j-\tau)}f(\tau)d\tau$. Then the next term $H_{j+1}$ is generated by

$$
H_{j+1} = e^{-\frac{-\alpha h}{1-\alpha}}H_j+\int_{t_j}^{t_{j+1}}e^{-\frac{\alpha}{1-\alpha}(t_{j+1}-\tau)}f(\tau)d\tau
$$

In this way, we can just add $\int_{t_j}^{t_{j+1}}e^{-\frac{\alpha}{1-\alpha}(t_{j+1}-\tau)}f(\tau)d\tau$ to the previously calculated value so that we can reduce computational cost.

## 3.3 Example

We will choose another FODE and the equation is given as below.

$$
^{CF}D_0^\alpha y(t)=y(t)-\alpha e^t(-1+e^{\frac{t}{-1+\alpha}})
$$

and its exact solution is

$$
y(t)=te^t
$$

As we did in the previous examples, we will check the convergence rate for PECE method and Fast method and they are of second order. We do not use convergence rate term $C_2$ for the same reason as Example 2.4.4. Also we will compare the time elapsed for calculation of 12 iterations from $i=1$ to $i=12$, by using ’tic-toc’ function.


# 4. Reference

[1] Richard L. Burden, J.Douglas Faires, Numerical Analysis Nineth Edition

[2] Thien Binh Nguyen, Bongsoo Jang, A High-Order Predictor-Corrector Method for Solving Nonlinear Differential Equations of Fractional Order(2017)]

[3] Junseo Lee, Seyeon Lee, and Bongsoo Jang, Direct Method for Solving Caputo-Fabrizion Differential Equations(2018)

[4] Kai Diethelm, Neville J. Ford, Alan D. Freed, A Predictor-Corrector Approach for the Numerical Solution of Fractional Differential Differential Equations(2002)

[5] Kia Diethelm, The Analysis of Fractional Differential Equations. An application-Oriented Exposition Using Diffeential Operators of Caputo Typles(2004)

[6] Toh, Yoke Teng, Phang, Chang, Loh, Jian Rong, New Predictor-Corrector Scheme for Solving Nonlinear Differential Equations with Caputo-Fabrizio Operator(2018)

[7] Jian Rong Loh, Abdulnasir Isah, Chang Phang, Yoke Teng Toh, On the New Properties of Caputo-Fabrizio Operator and its Application in Deriving Shifted Legendre Operational Matrix(2018)

[8] Junseo Lee, An efficient Numerical Approach for Solving Nonlinear Two-Points Boundary Value Problems with a Caputo Fractional Derivatives(2019)
