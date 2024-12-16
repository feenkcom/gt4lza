Class {
	#name : #GtLZAVPCsGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #views }
GtLZAVPCsGroup >> gtVpcsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'VPCs'; priority: 1; items: [self items]; column: 'Name' text: #name; column: 'Account' text: #account; column: 'Region' text: #region
]

{ #category : #accessing }
GtLZAVPCsGroup >> itemType [
	^ GtLZAVPC
]
