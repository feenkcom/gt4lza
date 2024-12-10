Class {
	#name : #GtLZAAccountsGroup,
	#superclass : #GtLZAGroup,
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAAccountsGroup >> gtAccountsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Accounts';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'E-Mail' text: #email;
		column: 'Description' text: #description;
		column: 'OU' text: [ :anAccount | anAccount organizationalUnit name ];
		column: 'Account type' text: #type
]

{ #category : #'as yet unclassified' }
GtLZAAccountsGroup >> itemType [
	^ GtLZAAccount
]
