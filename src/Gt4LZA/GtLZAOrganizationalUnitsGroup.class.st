Class {
	#name : #GtLZAOrganizationalUnitsGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #views }
GtLZAOrganizationalUnitsGroup >> gtOrganizationalUnitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Organizational units';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Children' text: [ :anOu | anOu children size ] width: 100
]

{ #category : #accessing }
GtLZAOrganizationalUnitsGroup >> itemType [
	^ GtLZAOrganizationalUnit
]
