Class {
	#name : #GtLZAAccount,
	#superclass : #GtLZAEntity,
	#instVars : [
		'description',
		'email',
		'organizationalUnit',
		'type',
		'managedEntities'
	],
	#category : #'Gt4LZA-Model'
}

{ #category : #adding }
GtLZAAccount >> addManagedEntity: anEntity [
	managedEntities add: anEntity
]

{ #category : #accessing }
GtLZAAccount >> description [
	^ description
]

{ #category : #accessing }
GtLZAAccount >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtLZAAccount >> email [
	^ email
]

{ #category : #accessing }
GtLZAAccount >> email: anObject [
	email := anObject
]

{ #category : #views }
GtLZAAccount >> gtManagedEntitiesFor: aView [
	<gtView>
	^ aView forward
		title: 'Managed entities';
		priority: 1;
		object: [ managedEntities ];
		view: #gtEntitiesFor:
]

{ #category : #initialization }
GtLZAAccount >> initialize [
	super initialize.
	
	managedEntities := GtLZAEntitiesGroup new
]

{ #category : #accessing }
GtLZAAccount >> managedEntities [
	^ managedEntities
]

{ #category : #accessing }
GtLZAAccount >> managedEntities: anObject [
	managedEntities := anObject
]

{ #category : #accessing }
GtLZAAccount >> managedEntitiesOfType: aClass [
	^ managedEntities select: [ :anEntity | anEntity isKindOf: aClass ]
]

{ #category : #accessing }
GtLZAAccount >> organizationalUnit [
	^ organizationalUnit
]

{ #category : #accessing }
GtLZAAccount >> organizationalUnit: anObject [
	organizationalUnit := anObject.
	organizationalUnit addChild: self
]

{ #category : #accessing }
GtLZAAccount >> paintOn: m [
	m nodes
		stencil: [ :anAccount | 
			| childrenContainer |
			childrenContainer := BrHorizontalPane new
					fitContent;
					alignCenter;
					padding: (BlInsets all: 5).
			childrenContainer graph beChildrenContainer: #default.
			BrVerticalPane new
				fitContent;
				margin: (BlInsets all: 5);
				border: (BlBorder paint: Color green darker width: 1);
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: anAccount name);
				addChild: childrenContainer ];
		with: (self managedEntitiesOfType: GtLZAVPC);
		forEach: [ :aVpc | aVpc paintOn: m ].
	m nodes
		stencil: [ :anAccount | 
			| childrenContainer |
			childrenContainer := BrHorizontalPane new
					fitContent;
					alignCenter;
					padding: (BlInsets all: 5).
			childrenContainer graph beChildrenContainer: #default.
			BrVerticalPane new
				fitContent;
				margin: (BlInsets all: 5);
				border: (BlBorder paint: Color purple lighter darker width: 1);
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: anAccount name);
				addChild: childrenContainer ];
		with: (self managedEntitiesOfType: GtLZATransitGateway)
			forEach: [ :aTransitGateway | aTransitGateway paintOn: m ].
	m layout vertical
]

{ #category : #accessing }
GtLZAAccount >> type [
	^ type
]

{ #category : #accessing }
GtLZAAccount >> type: anObject [
	type := anObject
]
