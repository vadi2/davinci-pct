//// Rulesets

RuleSet: SupportingInfoSlicing
* supportingInfo ^slicing.discriminator.type = #pattern
* supportingInfo ^slicing.discriminator.path = "category"
* supportingInfo ^slicing.rules = #open
* supportingInfo ^slicing.ordered = false   // can be omitted, since false is the default
* supportingInfo ^slicing.description = "Slice based on $this pattern"
* supportingInfo MS

RuleSet: Diagnosislicing
* diagnosis ^slicing.discriminator.type = #pattern
* diagnosis ^slicing.discriminator.path = "type"
* diagnosis ^slicing.rules = #open
* diagnosis ^slicing.ordered = false   // can be omitted, since false is the default
* diagnosis ^slicing.description = "Slice based on $this pattern"
* diagnosis MS

RuleSet: Procedurelicing
* procedure ^slicing.discriminator.type = #pattern
* procedure ^slicing.discriminator.path = "type"
* procedure ^slicing.rules = #open
* procedure ^slicing.ordered = false   // can be omitted, since false is the default
* procedure ^slicing.description = "Slice based on $this pattern"
* procedure MS

RuleSet: OrgContactSlicing
* contact ^slicing.discriminator.type = #pattern
* contact ^slicing.discriminator.path = "purpose"
* contact ^slicing.rules = #open
* contact ^slicing.ordered = false   // can be omitted, since false is the default
* contact ^slicing.description = "Slice based on $this pattern"
* contact MS

//// NOTE: based on CARIN-BB IG -- see C4BBExplanationOfBenefit profile
//// Invariants

// Invariant:  EOB-insurance-focal
// Description: "EOB.insurance:  at most one with focal = true"
// Expression: "insurance.select (focal = true).count() < 2"
// Severity:   #error

// Invariant: EOB-inst-careTeam-practitioner // rewritten with input from Lee Surprenant FHIR-28530
// Description: "Institutional EOB: Careteam roles refer to a practitioner"
// Expression: "(
// role.where(coding.where(code in ('attending' | 'primary' | 'referring' | 'supervising')).exists()).exists() implies
// role.where(coding.where(code in ('attending' | 'primary' | 'referring' | 'supervising')).exists()).exists().provider.all(resolve() is Practitioner)
// )"
// Severity: #error

// Invariant: EOB-pharm-careTeam-practitioner
// Description: "Pharmacy EOB:  Careteam roles refer to a practitioner"
// Expression: "(
// role.where(coding.where(code in ('primary' | 'prescribing' )).exists()).exists() implies
// role.where(coding.where(code in ('primary' | 'prescribing' )).exists()).exists().provider.all(resolve() is Organization)
// )"

// Invariant: EOB-institutional-item-or-header-adjudication
// Description: "Institutional EOB:  Should have adjudication at the item or header level, but not both"
// Expression: "(adjudication.exists() != item.adjudication.exists())"
// Severity: #error