# Assignment 7

## Basic requirements

### Q1 - 1 point
Can you open the pdf and it's not blank?

- No
- Yes

### Q2a - 1 point

Is the report anonymous?

- No
- Yes

### Q2b - 1 point
Does the report follow the formatting instructions?

- Not at all
- Little
- Mostly
- Yes

### Q2c - fail/pass

Are the evaluation questions answered and are the total number of hours put written down in the report. If not fail and resubmit.

### Q2d - fail/pass

Is an oral exam question contribution included? To pass this requirement, the submission must include one proposed oral exam question connected to this assignment, a short model answer, a brief indication that the question is not already in the oral exam list or very close to it, and a clear Yes/No statement about whether the course staff may use or adapt it in future oral exams. Students must not use large language models, such as ChatGPT, at all for the oral exam question contribution. If missing or clearly not serious, fail and resubmit.


## Hierarchical model: factory data with Stan

### Q3 - 3p

For the Pooled/Hiearchical and separate model (1p each) a): Is the model described using mathematical notation and the difference to other models described in words?

- No equations and no description
- Description but no equations (0.5p)
- Equations but no description (0.5p)
- Equations and description

### Q4 - 3p

For the Pooled/Hiearchical and separate model (1p each) b): Is there a related Stan implementation (N.B. same implementation may be used for multiple models)?

- No Stan model implemented, Stan model implemented, but it seems clearly wrong or broken
- Seemingly valid Stan model implemented

### Q5 - 3p

For the Pooled/Hiearchical and separate model (1p each) c) i): the posterior distribution of the mean of the quality measurements of the sixth machine.

- No means, CIs, discussion, histogram (or motivation of not including a histogram) or clearly incorrect response
- Only means, CIs, comment or histogram (or motivation of not including a histogram) (0.5p)
- Both means, CIs, comment and histogram (or motivation of not including a histogram)

### Q6 - 3p

For the Pooled/Hiearchical and separate model (1p each) c) ii): the predictive distribution of a quality measurement from the sixth machine

- No means, CIs, discussion, histogram (or motivation of not including a histogram) or clearly incorrect response
- Only means, CIs, comment or histogram (or motivation of not including a histogram) (0.5p)
- Both means, CIs, comment and histogram (or motivation of not including a histogram)


### Q7 - 3p

For the Pooled/Hiearchical and separate model (1p each) c) iii): the posterior distribution of the mean of the quality measurements of the seventh machine

- No means, CIs, discussion, histogram (or motivation of not including a histogram) or clearly incorrect response
- Only means, CIs, comment or histogram (or motivation of not including a histogram) (0.5p)
- Both means, CIs, comment and histogram (or motivation of not including a histogram)


### Q8 - 2p

In d), for the hierarchical model only (1p each): Are the marginal posteriors `p(theta | y)` and `p(log(tau) | y)` visualized and the parameters interpreted correctly? Here, `theta` is the population mean of the machine means and `tau` is the between-machine standard deviation.

For each of the two parameters:

- No valid posterior plot and no correct interpretation (0p)
- Valid posterior plot but missing or incorrect interpretation (0.5p)
- Correct interpretation but missing or incorrect posterior plot (0.5p)
- Valid posterior plot and correct interpretation (1p)

### Q9 - 2p

In e), is the joint posterior `p(mu_3, log(tau) | y)` visualized and its shape and dependence explained?

Joint posterior visualization (1p):

- Missing or clearly incorrect joint posterior plot; separate marginal plots alone are insufficient (0p)
- Joint posterior plot is provided but has minor errors or unclear axis labels (0.5p)
- Valid joint posterior plot with clearly labeled axes (1p)

Description and interpretation (1p):

- No explanation or clearly incorrect explanation (0p)
- Describes the observed shape or explains the relationship between `mu_3` and `log(tau)`, but the discussion is incomplete (0.5p)
- Describes the observed shape and explains correctly. (1p)

A pronounced funnel is not required for full credit; assess whether the explanation is consistent with the plotted posterior and the hierarchical model.

### Q10 - 3p

For the Pooled/Hiearchical and separate model (1p each): When using the prior of Gamma(1,1) for sigma parameter(s), the posterior for mu for machine 6 has 90% credibility intervals close to ...

- No or incorrect answer
- Answer is only partially correct (0.5p)
- Answers look correct

### Q11 - 1p

In f), is a reasonable explanation given?

- No or incorrect answer
- Yes
