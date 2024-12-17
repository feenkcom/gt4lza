Class {
	#name : #GtLZAOrganizationalUnit,
	#superclass : #GtLZAEntity,
	#instVars : [
		'accountAssociations',
		'policyAssociations',
		'transitGatewayAssociations'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAOrganizationalUnit >> accountAssociations [
	<MSEProperty: #accountAssociations type: #GtLZAAccountOrganizationalUnitAssociation opposite: #organizationalUnit>
	<multivalued>
	^ accountAssociations
]

{ #category : #accessing }
GtLZAOrganizationalUnit >> children [
	^ GtLZAEntitiesGroup new
		addAll: (accountAssociations collect: #account);
		addAll: (policyAssociations collect: #policy);
		addAll: (transitGatewayAssociations collect: #transitGateway);
		yourself
]

{ #category : #'gt-extension' }
GtLZAOrganizationalUnit >> gtChildrenFor: aView [
	<gtView>
	^ aView forward
		title: 'Children';
		priority: 1;
		object: [ self children ];
		view: #gtEntitiesFor:
]

{ #category : #initialization }
GtLZAOrganizationalUnit >> initialize [
	super initialize.
	accountAssociations := FMNullMultivalueLink
			on: self
			opposite: #organizationalUnit:
			selector: #accountAssociations.
	policyAssociations := FMNullMultivalueLink
			on: self
			opposite: #organizationalUnit:
			selector: #policyAssociations.
	transitGatewayAssociations := FMNullMultivalueLink
			on: self
			opposite: #organizationalUnit:
			selector: #transitGatewayAssociations
]

{ #category : #accessing }
GtLZAOrganizationalUnit >> policyAssociations [
	<MSEProperty: #policyAssociations type: #GtLZAOrganizationalUnitPolicyAssociation opposite: #organizationalUnit>
	<multivalued>
	^ policyAssociations
]

{ #category : #accessing }
GtLZAOrganizationalUnit >> transitGatewayAssociations [
	<MSEProperty: #transitGatewayAssociations type: #GtLZAOrganizationalUnitTransitGatewayAssociation opposite: #organizationalUnit>
	<multivalued>
	^ transitGatewayAssociations
]
