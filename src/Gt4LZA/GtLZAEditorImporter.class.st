Class {
	#name : #GtLZAEditorImporter,
	#superclass : #Object,
	#instVars : [
		'file',
		'model',
		'ast'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #importing }
GtLZAEditorImporter class >> importFileNamed: aFileReference source: aString into: editorModel [
	^ self new
		model: editorModel;
		importFileNamed: aFileReference source: aString
]

{ #category : #importing }
GtLZAEditorImporter >> addEntity: anEntity [
	file addEntity: anEntity.
	model addEntity: anEntity
]

{ #category : #importing }
GtLZAEditorImporter >> addLinksFor: anArray as: aClass [
	self
		addLinksFor: anArray
		from: ast object
		as: aClass
]

{ #category : #importing }
GtLZAEditorImporter >> addLinksFor: anArray at: anInteger from: anObject as: aClass [
	anInteger > anArray size
		ifTrue: [ | node |
			node := ast nodeForObject: anObject.
			^ file
				addAssociation: (GtLZAEditorAssociation new
						node: node;
						from: (self parentEntityOf: node);
						to: anObject;
						type: aClass;
						yourself) ].
	anObject isDictionary ifFalse: [ ^ self ].
	anObject
		at: (anArray at: anInteger)
		ifPresent: [ :next | 
			(next isString not and: [ next isCollection and: [ next isSequenceable ] ])
				ifTrue: [ next
						do: [ :each | 
							self
								addLinksFor: anArray
								at: anInteger + 1
								from: each
								as: aClass ] ]
				ifFalse: [ self
						addLinksFor: anArray
						at: anInteger + 1
						from: next
						as: aClass ] ]
]

{ #category : #importing }
GtLZAEditorImporter >> addLinksFor: anArray from: anObject as: aClass [
	self
		addLinksFor: anArray
		at: 1
		from: anObject
		as: aClass
]

{ #category : #importing }
GtLZAEditorImporter >> addLinksForAttribute: aString as: aClass [
	self
		addLinksForAttribute: aString
		from: ast object
		as: aClass
]

{ #category : #importing }
GtLZAEditorImporter >> addLinksForAttribute: aString from: anObject as: aClass [
	| collection |
	anObject isDictionary
		ifTrue: [ anObject
				at: aString
				ifPresent: [ :obj | 
					obj isString
						ifTrue: [ | node |
							node := ast nodeForObject: obj.
							file
								addAssociation: (GtLZAEditorAssociation new
										node: node;
										from: (self parentEntityOf: node);
										to: obj;
										type: aClass;
										yourself) ]
						ifFalse: [ (obj isCollection and: [ obj isSequenceable ])
								ifTrue: [ obj
										do: [ :each | 
											each isString
												ifTrue: [ | node |
													node := ast nodeForObject: each.
													file
														addAssociation: (GtLZAEditorAssociation new
																node: node;
																from: (self parentEntityOf: node);
																to: each;
																type: aClass;
																yourself) ] ] ] ] ].
			collection := anObject ]
		ifFalse: [ (anObject isCollection and: [ anObject isString not ])
				ifTrue: [ collection := anObject ] ].
	collection
		ifNotNil: [ collection
				do: [ :each | 
					self
						addLinksForAttribute: aString
						from: each
						as: aClass ] ]
]

{ #category : #importing }
GtLZAEditorImporter >> importAccounts [
	#('mandatoryAccounts' 'workloadAccounts')
		do: [ :each | 
			(ast object at: each ifAbsent: [ #() ])
				do: [ :acct | 
					| account |
					acct
						at: 'name'
						ifPresent: [ :name | 
							account := GtLZAEditorAccount name: name node: (ast nodeForObject: acct).
							self addEntity: account ] ] ]
]

{ #category : #importing }
GtLZAEditorImporter >> importFileNamed: aFileReference source: aString [
	| name files fileRef |
	ast := YAMLParser parseWithErrors: aString.
	name := model nameForFileReference: aFileReference.
	files := (model entities at: GtLZAEditorFile ifAbsentPut: [ Dictionary new ])
			at: name
			ifAbsentPut: [ OrderedCollection new ].
	fileRef := aFileReference absolutePath asFileReference.
	file := files
			detect: [ :each | each fileReference = fileRef ]
			ifNone: [ files
					add: ((GtLZAEditorFile name: name node: ast)
							model: model;
							fileReference: fileRef;
							yourself) ].
	file resetModel.
	file name = 'organization-config.yaml' ifTrue: [ self importOrganization ].
	file name = 'accounts-config.yaml' ifTrue: [ self importAccounts ].
	file name = 'network-config.yaml' ifTrue: [ self importNetwork ].
	self
		addLinksForAttribute: 'organizationalUnit'
		as: GtLZAEditorOrganizationalUnit.
	self
		addLinksForAttribute: 'organizationalUnits'
		as: GtLZAEditorOrganizationalUnit.
	self addLinksForAttribute: 'policy' as: GtLZAEditorFile.
	self addLinksForAttribute: 'template' as: GtLZAEditorFile.
	self addLinksForAttribute: 'document' as: GtLZAEditorFile.
	self addLinksForAttribute: 'rolePolicyFile' as: GtLZAEditorFile.
	self addLinksForAttribute: 'dynamicPartitioning' as: GtLZAEditorFile.
	^ file
]

{ #category : #importing }
GtLZAEditorImporter >> importNetwork [
	self importTransitGateways.
	self importVPCs
]

{ #category : #importing }
GtLZAEditorImporter >> importOrganization [
	(ast object at: 'organizationalUnits' ifAbsent: [ #() ])
		do: [ :each | 
			| unit |
			each
				at: 'name'
				ifPresent: [ :name | unit := GtLZAEditorOrganizationalUnit name: name node: (ast nodeForObject: each) ].
			self addEntity: unit ].
	#('serviceControlPolicies' 'taggingPolicies' 'backupPolicies')
		do: [ :key | 
			| policy |
			(ast object at: key ifAbsent: [ #() ])
				do: [ :each | 
					each
						at: 'name'
						ifPresent: [ :name | 
							policy := GtLZAEditorPolicy name: name node: (ast nodeForObject: each).
							self addEntity: policy ] ] ]
]

{ #category : #importing }
GtLZAEditorImporter >> importTransitGatewayAttachment: tga [
	| transitGatewayAttachment |
	transitGatewayAttachment := GtLZAEditorTransitGatewayAttachment new
			node: (ast nodeForObject: tga).
	tga at: 'name' ifPresent: [ :name | transitGatewayAttachment name: name ].
	self addEntity: transitGatewayAttachment.
	self
		addLinksFor: #('transitGateway' 'name')
		from: tga
		as: GtLZAEditorTransitGateway.
	self
		addLinksFor: #('transitGateway' 'account')
		from: tga
		as: GtLZAEditorAccount.
	self
		addLinksFor: #('routeTableAssociations')
		from: tga
		as: GtLZAEditorRouteTable.
	self
		addLinksFor: #('routeTablePropagations')
		from: tga
		as: GtLZAEditorRouteTable.
	self
		addLinksFor: #('subnets')
		from: tga
		as: GtLZAEditorSubnet
]

{ #category : #importing }
GtLZAEditorImporter >> importTransitGatewayAttachmentsFromVPC: aVPC [
	aVPC
		at: 'transitGatewayAttachments'
		ifPresent: [ :tgas | tgas do: [ :tga | self importTransitGatewayAttachment: tga ] ]
]

{ #category : #importing }
GtLZAEditorImporter >> importTransitGateways [
	(ast object at: 'transitGateways' ifAbsent: [ #() ])
		do: [ :tg | 
			| transitGateway |
			tg
				at: 'name'
				ifPresent: [ :name | 
					transitGateway := GtLZAEditorTransitGateway
							name: name
							node: (ast nodeForObject: tg).
					self addEntity: transitGateway ].
			self
				addLinksFor: #('account')
				from: tg
				as: GtLZAEditorAccount.
			tg
				at: 'shareTargets'
				ifPresent: [ :st | 
					| shareTarget |
					shareTarget := GtLZAEditorShareTarget new node: (ast nodeForObject: st).
					self addEntity: shareTarget.
					self
						addLinksFor: #('account')
						from: st
						as: GtLZAEditorAccount ].
			tg
				at: 'routeTables'
				ifPresent: [ :rtbls | 
					rtbls
						do: [ :rtbl | 
							| routeTable |
							rtbl
								at: 'name'
								ifPresent: [ :name | 
									routeTable := GtLZAEditorRouteTable name: name node: (ast nodeForObject: rtbl).
									self addEntity: routeTable ].
							rtbl
								at: 'routes'
								ifPresent: [ :rts | 
									| route |
									route := GtLZAEditorGatewayRoute new node: (ast nodeForObject: rts).
									self addEntity: route.

									rts
										do: [ :rte | 
											self
												addLinksFor: #('attachment' 'account')
												from: rte
												as: GtLZAEditorAccount.
											self
												addLinksFor: #('attachment' 'vpcName')
												from: rte
												as: GtLZAEditorVPC ] ] ] ] ]
]

{ #category : #importing }
GtLZAEditorImporter >> importVPCs [
	(ast object at: 'vpcs' ifAbsent: [ #() ])
		do: [ :each | 
			| vpc |
			vpc := GtLZAEditorVPC new node: (ast nodeForObject: each).
			each at: 'name' ifPresent: [ :name | vpc name: name ].
			self addEntity: vpc.
			each
				at: 'routeTables'
				ifPresent: [ :rtbls | 
					rtbls
						do: [ :rtbl | 
							| routeTable |
							rtbl
								at: 'name'
								ifPresent: [ :name | 
									routeTable := GtLZAEditorRouteTable name: name node: (ast nodeForObject: rtbl).
									self addEntity: routeTable ].
							rtbl
								at: 'routes'
								ifPresent: [ :rtes | 
									rtes
										do: [ :rte | 
											| route |
											route := GtLZAEditorRoute new node: (ast nodeForObject: rte).
											rte at: 'name' ifPresent: [ :name | route name: name ].
											self addEntity: route ] ] ] ].
			each
				at: 'natGateways'
				ifPresent: [ :gws | 
					gws
						do: [ :gw | 
							| natGateway |
							natGateway := GtLZAEditorNatGateway new node: (ast nodeForObject: gw).
							gw at: 'name' ifPresent: [ :name | natGateway name: name ].
							self addEntity: natGateway.
							self
								addLinksFor: #('subnet')
								from: gw
								as: GtLZAEditorSubnet ] ].
			self
				addLinksFor: #('account')
				from: each
				as: GtLZAEditorAccount.
			each
				at: 'subnets'
				ifPresent: [ :subs | 
					subs
						do: [ :sub | 
							| subnet |
							subnet := GtLZAEditorSubnet new node: (ast nodeForObject: sub).
							sub at: 'name' ifPresent: [ :name | subnet name: name ].
							self addEntity: subnet.
							self
								addLinksFor: #('routeTable')
								from: sub
								as: GtLZAEditorRouteTable ] ].
			self importTransitGatewayAttachmentsFromVPC: each ]
]

{ #category : #accessing }
GtLZAEditorImporter >> model [
	^ model
]

{ #category : #accessing }
GtLZAEditorImporter >> model: anObject [
	model := anObject
]

{ #category : #importing }
GtLZAEditorImporter >> parentEntityOf: node [
	| current |
	current := node parent.
	[ current notNil ]
		whileTrue: [ (current attributeNamed: #entity) ifNotNil: [ :entity | ^ entity ].
			current := current parent ].
	^ nil
]
