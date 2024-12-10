Class {
	#name : #GtLZAOrganizationalUnitsGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAOrganizationalUnitsGroup >> findNamed: aString [
	^ self
		detect: [ :anItem | anItem name = aString ]
		ifNone: [ | organizationalUnit |
			organizationalUnit := GtLZAOrganizationalUnit new name: aString.
			self add: organizationalUnit.
			^ organizationalUnit ]
]

{ #category : #'as yet unclassified' }
GtLZAOrganizationalUnitsGroup >> gtOrganizationalUnitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Organizational units';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Children' text: [ :anOu | anOu children size ] width: 100
]
