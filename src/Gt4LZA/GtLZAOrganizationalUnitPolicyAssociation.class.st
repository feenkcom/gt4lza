Class {
	#name : #GtLZAOrganizationalUnitPolicyAssociation,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'organizationalUnit',
		'policy'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZAOrganizationalUnitPolicyAssociation >> from [
	^ self policy
]

{ #category : #accessing }
GtLZAOrganizationalUnitPolicyAssociation >> organizationalUnit [
	<MSEProperty: #organizationalUnit type: #GtLZAOrganizationalUnit opposite: #policyAssociations>
	^ organizationalUnit
]

{ #category : #accessing }
GtLZAOrganizationalUnitPolicyAssociation >> organizationalUnit: anObject [
	organizationalUnit := FMMultivalueLink
			on: self
			update: #policyAssociations
			from: self organizationalUnit
			to: anObject
]

{ #category : #accessing }
GtLZAOrganizationalUnitPolicyAssociation >> policy [
	<MSEProperty: #policy type: #GtLZAPolicy opposite: #organizationalUnitAssociations>
	^ policy
]

{ #category : #accessing }
GtLZAOrganizationalUnitPolicyAssociation >> policy: anObject [
	policy := FMMultivalueLink
			on: self
			update: #organizationalUnitAssociations
			from: self policy
			to: anObject
]

{ #category : #accessing }
GtLZAOrganizationalUnitPolicyAssociation >> to [
	^ self organizationalUnit
]
