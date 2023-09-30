---
layout: distill
hidden: true
title: Problems with Almost-Sure Guarantees of Stochastic CBFs.
date: 2023-09-29
tags: math cbf safety
authors:
  - name: Oswin So
    url: "oswinso.xyz"
    affiliations:
      name: Massachusetts Institute of Technology
bibliography: 2023-09-29-stochastic-almost-sure.bib

_styles: >
    .theorem {
        display: block;
        font-style: italic;
    }
    .theorem:before {
        content: "Theorem. ";
        font-weight: bold;
        font-style: normal;
    }
    .theorem[text]:before {
        content: "Theorem (" attr(text) ")  ";
    }
---
I've always been found Andrew Clark's proofs on Stochastic CBFs <d-cite key="clark2019control,clark2021control"></d-cite> to be very impressive.
Specifically, it was very impressive that stochastic CBFs could guarantee that safety holds _almost-surely_ for stochastic systems in continuous time. 
In fact, a little too impressive. Consequently, while trying to see how the proof worked, I discovered a potential mistake in the proof related to the technicalities of stochastic processes.

To lay the context, consider the following SDE (making the usual regularity assumptions to ensure existence).

\begin{equation}
    dx_t = \Big( f(x_t) + g(x_t) u_t \Big) dt + \sigma(x_t) dW_t
\end{equation}

Stochastic (zero)-CBFs are defined as a function $h$ that satisfies the following stochastic-analogue of the deterministic CBF condition.
Namely, for all $x$ such that $h(x) > 0$, there exists a $u$ satisfying the condition

\begin{equation} \label{eq:scbf_condition}
\frac{\partial h}{\partial x} \Big( f(x) + g(x) u \Big) + \frac{1}{2}\mathop{tr}\left[ \sigma \sigma^\mathsf{T} \frac{\partial^2 h}{\partial x^2} \right] \geq -h(x)
\end{equation}

Define the zero superlevel set of $h$ as $\mathcal{C}$, i.e., $\mathcal{C} \coloneqq \\{ x \mid h(x) \geq 0 \\}$
Then, it is shown in <d-cite key="clark2021control"></d-cite> that the satisfaction of \eqref{eq:scbf_condition} guarantees that $\mathcal{C}$ is forward-invariant _almost-surely_:

<div class="theorem" text="Almost-Sure Safety of Stochastic CBFs">
If $u$ satisfies \eqref{eq:scbf_condition}, then $\mathop{Pr}(x_t \in \mathcal{C}\; \forall t) = 1$ provided that $x_0 \in \mathcal{C}$.
</div>

## Problems when used on Brownian Motion
To illustrate the problem in the proof, we first consider a simpler scenario by taking $f = 0, g=0, \sigma=1$, giving us the SDE

\begin{equation}
    dx_t = dW_t
\end{equation}

In other words, $x_t = W_t$ is exactly Brownian motion. If we next define the function $h$ as

\begin{equation}
    h(x) \coloneqq x
\end{equation}

We can then verify that \eqref{eq:scbf_condition} easily holds in this case, since, for $h(x) > 0$,

\begin{equation} \label{eq:scbf_condition_W}
     0 \geq -h(x)
\end{equation}

In this case, $\mathcal{C} \coloneqq \\{ x \mid x \geq 0 \\}$. The theorem then reduces to the following _alarming_ result (using that $x_t = W_t$).

<div class="theorem" text="Brownian Motion is Non-Negative Almost-Surely.">
    Suppose $W_t \geq 0$. Then, $\mathop{Pr}(W_t \geq 0\; \forall t) = 1$.
</div>

However, since Brownian motion has unbounded support, we know that this cannot be true. To try and see how we came to this conclusion, we now trace through the proof technique from <d-cite key="clark2021control"></d-cite> applied to this simple example.

## Tracing through the proof
<blockquote>
It is sufficient to show that, for any $t > 0$, and any $\epsilon > 0$, and any $\delta \in (0, 1)$,

\begin{equation}
    \mathop{Pr}\left( \inf_{t' < t} W(t') < -\epsilon \right) < \delta.
\end{equation}

Let $\theta = \min\left\{ \frac{\delta \epsilon}{2t}, W(0) \right\}$. We now construct a sequence of <strong>stopping times</strong> $\eta_i$ and $\zeta_i$ for $i=0, 1, \dots$ as

\begin{align}
    \eta_0 &= 0, \quad \zeta_0 = \inf\Big\{ t : W(t) > \theta \Big\}, \newline
    \eta_i &= \inf \Big\{ t : W(t) < \theta, \; t > \zeta_{i-1} \Big\}, \quad i = 1, 2, \dots \newline
    \zeta_i &= \inf \Big\{ t : W(t) > \theta, \; t > \eta_{i-1} \Big\}, \quad i = 1, 2, \dots \newline
\end{align}
</blockquote>

One problem here is that the random variables $\zeta_1$ and $\eta_i, \zeta_i$ for $i>0$ are not elements of $\mathcal{F}_t$ but rather $\mathcal{F}_t+$, since the sets $\\{ x \mid x > \theta \\}$ are not closed.
Consequently, these random variables are **not** stopping times.

However, this is not the only problem. For now, we assume this does not matter and continue with the proof.

<blockquote>
Define the supermartingale $U_t$ as

\begin{equation}
    U_t = \theta + \sum_{i=0}^\infty \left( \int_{\eta_i \land t}^{\zeta_i \land t} -\theta \, d\tau + \int_{\eta_i \land t}^{\zeta_i \land t} dW_\tau \right) 
\end{equation}

such that

\begin{equation}
    \mathbb{E}[U_t \mid U_s] = U_s + \mathbb{E}\left[ \sum_{i=0}^\infty \int_{\eta_i \land t}^{\zeta_i \land t} -\theta \, d\tau \right] \leq U_s.
\end{equation}

We will prove by induction that $W(t) \geq U_t$ and $U_t \leq \theta$. Initially, $U_0 = \theta \leq W(0)$ by construction.

<div>
<strong>Case 1:</strong>
</div>
Suppose that the result holds up to time $t \in [\eta_i, \zeta_i]$ for all $i \geq 0$. Then, $W_t$ and $U_t$ are given by

\begin{align}
    W_t &= W_{\eta_i} + \int_{\eta_i}^t dW_\tau \newline
    U_t &= U_{\eta_i} + \int_{\eta_i}^t -\theta\, d\tau + \int_{\eta_i}^t dW_\tau
\end{align}

Since $W(t) \leq \theta$ for $t \in [\eta_i, \zeta_i]$ by definition of $\eta$ and $\zeta$, \eqref{eq:scbf_condition_W} implies that

\begin{equation}
    0 \geq -W(t) \geq -\theta.
\end{equation}

Hence,

\begin{equation}
    W_t - U_t = \left( W_{\eta_i} - U_{\eta_i} \right) + \int_{\eta_i}^t \theta\, d\tau \geq 0.
\end{equation}

and $W(t) \geq U_t$. Furthermore, for $t \in [\eta_i, \zeta_i]$, $W(t) \leq \theta$, hence $U_t \leq \theta$.

<div>
<strong>Case 2:</strong>
</div>
Now, suppose that the result holds up to time $t \in [\zeta_i, \eta_{i+1}]$, we have that

\begin{equation}
    U_t = U_{\zeta_i} \leq W(\zeta_i) = \theta \leq W(t)
\end{equation}

by definition of $\zeta_i$. Hence, by induction,

\begin{equation} \label{eq:induction_conclusion}
    W(t) \geq U_t, \quad \text{and} \quad U_t \leq \theta.
\end{equation}
</blockquote>

One problem with this proof by induction is that it is not explicit _for what values of $t$_ this statement is valid for.
The proof takes this to be all $t \geq 0$, but the structure of the induction means that this only holds over the union of the intervals $[\eta_i, \zeta_i]$ and $[\zeta_i, \eta_{i+1}]$.
For this to be equal to $t \geq 0$ requires that $\lim_{i \to \infty} \xi_i = \lim_{i \to \infty} \zeta_i = \infty$.

However, this is **not** the case, since it is possible that $\eta_i = \zeta_i = \eta_1$ for all $i \geq 1$.
Actually, this happens _almost surely_, since $W$ will go above and below $\theta$ immediately after hitting $\theta$.
Without loss of generality, suppose $W(0) = \theta$. Then,

\begin{equation}
    \inf\\{ t > 0 \mid W(t) > \theta \\} = \inf\\{ t > 0 \mid W(t) < \theta \\} = 0,\; \textrm{a.s.}
\end{equation}

The proof then continues by assuming that \eqref{eq:induction_conclusion} to be true for all $t \geq 0$, which then leads to the incorrect conclusion.

<div hidden>
<blockquote>
Since $U_t \leq W(t)$, we have that

\begin{equation}
    \mathop{Pr}\left( \inf_{t' < t} W(t') < -\epsilon\right) \leq \mathop{Pr}\left( \inf_{t' < t} U(t') < -\epsilon\right)
\end{equation}

Applying Doob's Martingale Inequality gives us that

\begin{equation}
    \mathop{Pr}\left( \inf_{0 \leq t \leq T} U_t < -\epsilon \right) \leq \frac{\mathbb{E}[\max(-U_T, 0)]}{\epsilon}.
\end{equation}

We can bound $\mathbb{E}[U_T]$ by noting that

\begin{equation}
    \mathbb{E}[U_T] = \theta + \mathbb{E}\left[ \sum_{i=0}^\infty \int_{\eta_i \land t}^{\zeta_i \land t} -\theta \, d\tau \right] \geq \theta - \theta T
\end{equation}

We also know that $U_T \leq \theta$ almost surely, hence $\mathbb{E}[\max(U_T, 0)] \leq \theta$.
Combining these two statements gives us that

\begin{equation}
    \mathbb{E}[\max(-U_T, 0)] \leq \theta -\theta + \theta T = \theta T
\end{equation}

which gives us
\begin{align}
P\left( \inf_{0 \leq t \leq T} B_t < -\epsilon \right) \leq \frac{\theta T}{\epsilon} = \frac{\delta \epsilon}{2T} \frac{T}{\epsilon} < \delta
\end{align}

</blockquote>
</div>

# Citation
Cited as:
> So, Oswin. (Sep 2023). Problems with Almost-Sure Guarantees of Stochastic CBFs. Oswin's Blog. https://oswinso.xyz/blog/2023/stochastic-cbf-almost-sure/

Or
```bibtex
@article{so2023potential,
  title   = "Problems with Almost-Sure Guarantees of Stochastic CBFs",
  author  = "So, Oswin",
  journal = "oswinso.xyz",
  year    = "2023",
  month   = "Sep",
  url     = "https://oswinso.xyz/blog/2023/stochastic-cbf-almost-sure/"
}
```