Class {
	#name : #GtLZAPoliciesGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAPoliciesGroup >> gtPoliciesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Policies';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Description' text: #description;
		column: 'Type' text: #type;
		column: 'Exists'
			icon: [ :aPolicy | aPolicy exists
					ifTrue: [ BrGlamorousVectorIcons accept ]
					ifFalse: [ BrGlamorousVectorIcons cancel ] ]
]

{ #category : #'as yet unclassified' }
GtLZAPoliciesGroup >> itemType [
	^ GtLZAPolicy
]
