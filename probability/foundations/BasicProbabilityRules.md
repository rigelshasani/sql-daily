
# From A-B Tests to Addition Rules
*September 17, 2025*
  

Today's probability foundations session provided a significant conceptual breakthrough in my data analytics exploration. The experience highlighted the crucial distinction between intuitive application of statistical concepts and formal mathematical understanding of their underlying principles.

## Identifying Prior Knowledge

First I assessed my existing probability knowledge within my A/B testing experience: statistical significance, conversion rates, significance thresholds, and representative sampling.

I had been employing probability frameworks without formal recognition of the mathematical structures involved.

## The Addition Rule Discovery


Using an e-commerce scenario (60% mobile users, 30% return customers, 15% overlap), I calculated the probability of "mobile OR return customer."

Initial response: 60% + 30% = 90%

This revealed the fundamental error of double-counting overlapping probabilities. The correct approach emerged through guided questioning:

**P(A OR B) = P(A) + P(B) - P(A AND B) = 60% + 30% - 15% = 75%**

## The Multiplication Rule Application

Next challenge: probability that a random visitor is both mobile AND converts (given 40% mobile conversion rate).

**P(Mobile AND Converts) = P(Mobile) × P(Converts | Mobile) = 0.60 × 0.40 = 0.24**

The realistic scenario (25% mobile conversion rate) yielded 15%, demonstrating how assumptions about independence affect real-world applications.

## Integration with Existing Knowledge

I connected formal probability rules to familiar A/B testing concepts:

- Conversion rates as conditional probabilities
- Statistical significance as probability calculations
- Sample representativeness as population probability matching

## Implications

These foundational rules provide the mathematical framework for advanced topics: conditional probability, Bayes theorem, and statistical testing methodologies that underpin business analytics decision-making.

---