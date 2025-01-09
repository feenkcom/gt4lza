Class {
	#name : #GtLZAEditorModel,
	#superclass : #Object,
	#instVars : [
		'entities',
		'directory',
		'updates'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #'instance creation' }
GtLZAEditorModel class >> onDirectory: aFileReference [
	^ self new
		directory: aFileReference;
		yourself
]

{ #category : #importing }
GtLZAEditorModel >> addEntity: anObject [
	((self entities at: anObject class ifAbsentPut: [ Dictionary new ])
		at: anObject name
		ifAbsentPut: [ OrderedCollection new: 1 ]) add: anObject
]

{ #category : #accessing }
GtLZAEditorModel >> allAccountNames [
	self ensureAccountsConfigLoaded.
	^ (entities at: GtLZAEditorAccount ifAbsent: [ Dictionary new ]) keys
]

{ #category : #accessing }
GtLZAEditorModel >> allOrganizationalUnitNames [
	self ensureOrganizationConfigLoaded.
	^ (entities at: GtLZAEditorOrganizationalUnit ifAbsent: [ Dictionary new ])
		keys
]

{ #category : #accessing }
GtLZAEditorModel >> allVPCNames [
	self ensureNetworkConfigLoaded.
	^ (entities at: GtLZAEditorVPC ifAbsent: [ Dictionary new ]) keys
]

{ #category : #accessing }
GtLZAEditorModel >> directory [
	^ directory
]

{ #category : #accessing }
GtLZAEditorModel >> directory: anObject [
	directory := anObject
]

{ #category : #accessing }
GtLZAEditorModel >> ensureAccountsConfigLoaded [
	(self entityNamed: 'accounts-config.yaml' ofType: GtLZAEditorFile)
		ifNil: [ self loadAccountsConfig ]
]

{ #category : #accessing }
GtLZAEditorModel >> ensureNetworkConfigLoaded [
	(self entityNamed: 'network-config.yaml' ofType: GtLZAEditorFile)
		ifNil: [ self loadNetworkConfig ]
]

{ #category : #accessing }
GtLZAEditorModel >> ensureOrganizationConfigLoaded [
	(self entityNamed: 'organization-config.yaml' ofType: GtLZAEditorFile)
		ifNil: [ self loadOrganizationConfig ]
]

{ #category : #accessing }
GtLZAEditorModel >> entities [
	^ entities ifNil: [ entities := Dictionary new ]
]

{ #category : #accessing }
GtLZAEditorModel >> entities: anObject [
	entities := anObject
]

{ #category : #accessing }
GtLZAEditorModel >> entityNamed: aString ofType: aClass [
	self loadUpdates.
	^ self entities
		at: aClass
		ifPresent: [ :dict | 
			dict
				at: aString
				ifPresent: [ :col | col at: 1 ifAbsent: [  ] ]
				ifAbsent: [  ] ]
		ifAbsent: [  ]
]

{ #category : #accessing }
GtLZAEditorModel >> fileEntityNamed: aFileReference [
	^ (self entityNamed: aFileReference basename ofType: GtLZAEditorFile)
		ifNil: [ self loadFile: aFileReference ]
]

{ #category : #views }
GtLZAEditorModel >> gtAccountsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Accounts';
		items: [ (entities at: GtLZAEditorAccount ifAbsent: [ Dictionary new ]) flattened
				asSortedCollection: [ :a :b | a name < b name ] ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Name' text: [ :each | each name ]
]

{ #category : #views }
GtLZAEditorModel >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowExplicitTool new
				name: self gtDisplayString;
				stencil: [ GtLZACoder new model: self ]);
		addTool: super gtDefaultInspectorTool
]

{ #category : #views }
GtLZAEditorModel >> gtFilesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Files';
		items: [ (entities at: GtLZAEditorFile ifAbsent: [ Dictionary new ]) flattened
				asSortedCollection: [ :a :b | a name < b name ] ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Name' text: [ :each | each name ]
]

{ #category : #views }
GtLZAEditorModel >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ GtLZACoder new model: self ]
]

{ #category : #views }
GtLZAEditorModel >> gtOrganizationalUnitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Organizational units';
		items: [ (entities at: GtLZAEditorOrganizationalUnit ifAbsent: [ Dictionary new ])
				flattened asSortedCollection: [ :a :b | a name < b name ] ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Name' text: [ :each | each name ]
]

{ #category : #views }
GtLZAEditorModel >> gtPoliciesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Policies';
		items: [ (entities at: GtLZAEditorPolicy ifAbsent: [ Dictionary new ]) flattened
				asSortedCollection: [ :a :b | a name < b name ] ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Name' text: [ :each | each name ]
]

{ #category : #views }
GtLZAEditorModel >> gtRouteTablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Route tables';
		items: [ (entities at: GtLZAEditorRouteTable ifAbsent: [ Dictionary new ]) flattened
				asSortedCollection: [ :a :b | a name < b name ] ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Name' text: [ :each | each name ]
]

{ #category : #views }
GtLZAEditorModel >> gtTransitGatewaysFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Transit gateways';
		items: [ (entities at: GtLZAEditorTransitGateway ifAbsent: [ Dictionary new ]) flattened
				asSortedCollection: [ :a :b | a name < b name ] ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Name' text: [ :each | each name ]
]

{ #category : #views }
GtLZAEditorModel >> gtVPCsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'VPCs';
		items: [ (entities at: GtLZAEditorVPC ifAbsent: [ Dictionary new ]) flattened
				asSortedCollection: [ :a :b | a name < b name ] ];
		column: 'Index'
			text: [ :each :index | index asRopedText foreground: Color gray ]
			width: 45;
		column: 'Name' text: [ :each | each name ]
]

{ #category : #importing }
GtLZAEditorModel >> importAccountsFrom: ast into: file [
	#('mandatoryAccounts' 'workloadAccounts')
		do: [ :each | 
			(ast object at: each ifAbsent: [ #() ])
				do: [ :acct | 
					| account |
					acct
						at: 'name'
						ifPresent: [ :name | 
							account := GtLZAEditorAccount name: name node: (ast nodeForObject: acct).
							file addEntity: account.
							self addEntity: account ].
					acct
						at: 'organizationalUnit'
						ifPresent: [ :name | 
							file
								addAssociation: (GtLZAEditorIndirectAssociation new
										node: (ast nodeForObject: name);
										from: account;
										to: name;
										type: GtLZAEditorOrganizationalUnit;
										yourself) ] ] ]
]

{ #category : #importing }
GtLZAEditorModel >> importNetworkFrom: ast into: file [
	(ast object at: 'transitGateways' ifAbsent: [ #() ])
		do: [ :tg | 
			| transitGateway |
			tg
				at: 'name'
				ifPresent: [ :name | 
					transitGateway := GtLZAEditorTransitGateway
							name: name
							node: (ast nodeForObject: tg).
					file addEntity: transitGateway.
					self addEntity: transitGateway ].
			tg
				at: 'routeTables'
				ifPresent: [ :rtbls | 
					rtbls
						do: [ :rtbl | 
							rtbl
								at: 'name'
								ifPresent: [ :name | 
									| routeTable |
									routeTable := GtLZAEditorRouteTable
											name: name
											node: (ast nodeForObject: rtbl).
									file addEntity: routeTable.
									self addEntity: routeTable ] ] ] ].
	(ast object at: 'vpcs' ifAbsent: [ #() ])
		do: [ :each | 
			| vpc |
			each
				at: 'name'
				ifPresent: [ :name | 
					vpc := GtLZAEditorVPC name: name node: (ast nodeForObject: each).
					file addEntity: vpc.
					self addEntity: vpc ].
			each
				at: 'routeTables'
				ifPresent: [ :rtbls | 
					rtbls
						do: [ :rtbl | 
							rtbl
								at: 'name'
								ifPresent: [ :name | 
									| routeTable |
									routeTable := GtLZAEditorRouteTable
											name: name
											node: (ast nodeForObject: rtbl).
									file addEntity: routeTable.
									self addEntity: routeTable ] ] ] ]
]

{ #category : #importing }
GtLZAEditorModel >> importOrganizationFrom: ast into: file [
	(ast object at: 'organizationalUnits' ifAbsent: [ #() ])
		do: [ :each | 
			| unit |
			each
				at: 'name'
				ifPresent: [ :name | unit := GtLZAEditorOrganizationalUnit name: name node: (ast nodeForObject: each) ].
			file addEntity: unit.
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
							file addEntity: policy.
							self addEntity: policy ].
					each
						at: 'deploymentTargets'
						ifPresent: [ :dt | 
							dt
								at: 'organizationalUnits'
								ifPresent: [ :units | 
									units
										do: [ :unit | 
											file
												addAssociation: (GtLZAEditorDirectAssociation new
														node: (ast nodeForObject: unit);
														from: policy;
														to: (self entityNamed: unit ofType: GtLZAEditorOrganizationalUnit)) ] ] ] ] ]
]

{ #category : #initalization }
GtLZAEditorModel >> initialize [
	super initialize.
	updates := Dictionary new
]

{ #category : #importing }
GtLZAEditorModel >> loadAccountsConfig [
	self loadFile: directory / 'accounts-config.yaml'
]

{ #category : #importing }
GtLZAEditorModel >> loadFile: aFileReference [
	| name source |
	name := aFileReference absolutePath asFileReference.
	source := updates
			at: name
			ifAbsent: [ name contents ].
	updates removeKey: name ifAbsent: [  ].
	^ self loadFileNamed: aFileReference source: source
]

{ #category : #importing }
GtLZAEditorModel >> loadFileNamed: aFileReference source: aString [
	| ast file name files fileRef |
	ast := YAMLParser parseWithErrors: aString.
	name := aFileReference basename.
	files := (entities at: GtLZAEditorFile ifAbsentPut: [ Dictionary new ])
			at: name
			ifAbsentPut: [ OrderedCollection new ].
	fileRef := aFileReference absolutePath asFileReference.
	file := files
			detect: [ :each | each fileReference = fileRef ]
			ifNone: [ files
					add: ((GtLZAEditorFile name: name node: ast)
							model: self;
							fileReference: fileRef;
							yourself) ].
	file resetModel.
	file name = 'organization-config.yaml'
		ifTrue: [ self importOrganizationFrom: ast into: file ].
	file name = 'accounts-config.yaml'
		ifTrue: [ self importAccountsFrom: ast into: file ].
	file name = 'network-config.yaml'
		ifTrue: [ self importNetworkFrom: ast into: file ].
	^ file
]

{ #category : #importing }
GtLZAEditorModel >> loadNetworkConfig [
	self loadFile: directory / 'network-config.yaml'
]

{ #category : #importing }
GtLZAEditorModel >> loadOrganizationConfig [
	self loadFile: directory / 'organization-config.yaml'
]

{ #category : #importing }
GtLZAEditorModel >> loadUpdates [
	| oldUpdates |
	updates isEmpty ifTrue: [ ^ self ].
	oldUpdates := updates.
	updates := Dictionary new.
	oldUpdates
		keysAndValuesDo: [ :key :value | self loadFileNamed: key source: value ]
]

{ #category : #importing }
GtLZAEditorModel >> removeEntitiesFor: filename [
	(self entityNamed: filename ofType: GtLZAEditorFile)
		ifNotNil: [ :file | 
			file entities do: [ :each | self removeEntity: each ] ]
]

{ #category : #importing }
GtLZAEditorModel >> removeEntity: anObject [
	self entities
		at: anObject class
		ifPresent: [ :dict | 
			dict
				at: anObject name
				ifPresent: [ :col | 
					col remove: anObject ifAbsent: [  ].
					col isEmpty ifTrue: [ dict removeKey: anObject name ifAbsent: [  ] ] ] ]
]

{ #category : #importing }
GtLZAEditorModel >> updateFile: aFileReference with: aString [
	| name |
	name := aFileReference basename.
	self removeEntitiesFor: name.
	updates at: aFileReference put: aString
]
