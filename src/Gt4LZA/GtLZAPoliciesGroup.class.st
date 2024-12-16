Class {
	#name : #GtLZAPoliciesGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #views }
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

{ #category : #accessing }
GtLZAPoliciesGroup >> itemType [
	^ GtLZAPolicy
]
