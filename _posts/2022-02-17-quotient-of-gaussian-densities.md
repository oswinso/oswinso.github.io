---
layout: post
title: Quotient of Gaussian Densities
date: 2022-02-17
description: Quick derivation of quotient of Gaussian densities so it's somewhere.
tags: math
---

# Statement

Let $p$ and $q$ denote Gaussian pdfs with the form

\begin{align}
p(x) &= Z_p^{-1} \exp\left( -\frac{1}{2} (x-\mu_p)\T \Sigma_p^{-1} (x-\mu_p) \right) \newline
q(x) &= Z_q^{-1} \exp\left( -\frac{1}{2} (x-\mu_q)\T \Sigma_q^{-1} (x-\mu_q) \right)
\end{align}

Our goal is to show that the quotient $\frac{p(x)}{q(x)}$ takes the form

\begin{equation}
\frac{p(x)}{q(x)} = w^{-1} \exp \left( -\frac{1}{2} (x - \mu)\T \Sigma^{-1} (x-\mu) \right)
\end{equation}

where
\begin{align}
\Sigma &\coloneqq (\Sigma_p^{-1} - \Sigma_q^{-1})^{-1} \newline
\mu &\coloneqq \Sigma (\Sigma_p^{-1} \mu_p - \Sigma_q^{-1} \mu_q) \newline
w^{-1} &\coloneqq \frac{ \lvert \Sigma_p \rvert^{\frac{1}{2}} }{ \lvert \Sigma_p\rvert^{\frac{1}{2}} }
\exp\left(-\frac{1}{2} \Big[ \mu_p\T \Sigma_p^{-1} \mu_p - \mu_q\T \Sigma_q^{-1} - 
\mu\T \Sigma^{-1} \mu
\Big] \right)
\end{align}

Note that $\frac{p(x)}{q(x)}$ is **not normalized** and hence is not necessarily a probability density function.

# Derivation

We first note the formula for completing the square:

\begin{equation}
\frac{1}{2} x\T P x - q\T x
= \frac{1}{2} (x - P^{-1} q)\T P (x - P^{-1} q) - \frac{1}{2} q\T P^{-1} q
\end{equation}

Now,

\begin{align}
&\mathrel{\phantom{=}} \frac{1}{2} (x - \mu_p)\T \Sigma_p^{-1} (x - \mu_p) -
\frac{1}{2} (x - \mu_q)\T \Sigma_q^{-1} (x - \mu_q) \newline
&= \frac{1}{2} x\T (\Sigma_p^{-1} - \Sigma_q^{-1}) x -
(\Sigma_p^{-1} \mu_p - \Sigma_q^{-1} \mu_q)\T x +
    \frac{1}{2} \mu_p\T \Sigma_p^{-1} \mu_p -
    \frac{1}{2} \mu_q\T \Sigma_q^{-1} \mu_q
\end{align}
\shortintertext{Defining $m \coloneqq \Sigma_p^{-1} \mu_p - \Sigma_q^{-1} \mu_q$ and $\Sigma$ as above,}
\begin{align}
&= \frac{1}{2} x\T \Sigma^{-1} x - m\T x + 
    \frac{1}{2} \mu_p\T \Sigma_p^{-1} \mu_p - 
    \frac{1}{2} \mu_q\T \Sigma_q^{-1} \mu_q \newline
&= \frac{1}{2} (x - \mu)\T \Sigma^{-1} (x - \mu) -
    \frac{1}{2} \mu\T \Sigma^{-1} \mu +
    \frac{1}{2} \mu_p\T \Sigma_p^{-1} \mu_p -
    \frac{1}{2} \mu_q\T \Sigma_q^{-1} \mu_q \newline
&= \frac{1}{2} \Big[ (x - \mu)\T \Sigma^{-1} (x - \mu) +
    \mu_p\T \Sigma_p^{-1} \mu_p - 
    \mu_q\T \Sigma_q^{-1} -
    \mu\T \Sigma^{-1} \mu \Big]
\end{align}

Finally,

\begin{align}
\frac{ p(x) }{ q(x) }
&= \frac{ \lvert \Sigma_q \rvert^{\frac{1}{2}} }{ \lvert \Sigma_p \rvert^{\frac{1}{2}} }
\exp\left( -\frac{1}{2} \Big[
(x - \mu_p)\T \Sigma_p^{-1} (x - \mu_p) -
(x - \mu_q)\T \Sigma_q^{-1} (x - \mu_q)
\Big]\right) \newline
&= \frac{ \lvert \Sigma_q \rvert^{\frac{1}{2}} }{ \lvert \Sigma_p \rvert^{\frac{1}{2}} }
\exp\left(-\frac{1}{2} \Big[
(x - \mu)\T \Sigma^{-1} (x - \mu) +
    \mu_p\T \Sigma_p^{-1} \mu_p -
    \mu_q\T \Sigma_q^{-1} -
    \mu\T \Sigma^{-1} \mu
\Big]\right) \newline
&= w^{-1} \exp\left( -\frac{1}{2} (x - \mu)\T \Sigma^{-1} (x - \mu) \right)
\end{align}

where

\begin{equation}
w^{-1} \coloneqq
\frac{ \lvert \Sigma_q \rvert^{\frac{1}{2}} }{ \lvert \Sigma_p \rvert^{\frac{1}{2}} }
\exp\left(-\frac{1}{2} \Big[
\mu_p\T \Sigma_p^{-1} \mu_p -
    \mu_q\T \Sigma_q^{-1} -
    \mu\T \Sigma^{-1} \mu
\Big] \right)
\end{equation}
