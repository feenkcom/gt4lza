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
GtLZAEditorModel >> asyncEntities [
	^ (self entities keys asArray asAsyncStream
		collect: [ :each | (self entities at: each ifAbsent: [ #() ]) values flattened asAsyncStream ])
		flatten
]

{ #category : #accessing }
GtLZAEditorModel >> asyncFiles [
	^ (self entities at: GtLZAEditorFile ifAbsent: [ #() ]) flattened asAsyncStream
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
	^ self privateEntityNamed: aString ofType: aClass
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
				withLabelAndIconAptitude;
				name: 'LZA';
				icon: BrGlamorousVectorIcons browse;
				stencil: [ GtLZACoder new model: self ]);
		addTool: super gtDefaultInspectorTool
]

{ #category : #search }
GtLZAEditorModel >> gtEntitySearch: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 20;
		title: 'Entities';
		items: [ self asyncEntities select: #hasName ];
		itemName: [ :each | each name asString ];
		filterBySubstring
]

{ #category : #search }
GtLZAEditorModel >> gtFileSearch: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Files';
		items: [ (self entities at: GtLZAEditorFile ifAbsent: [ #() ]) flattened ];
		itemName: [ :each | each name asString ];
		filterBySubstring
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

{ #category : #search }
GtLZAEditorModel >> gtStringSearch: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 30;
		title: 'String search';
		search: [ :aContext | 
			| string |
			string := aContext searchQuery asUppercase.
			((((self entities at: GtLZAEditorFile ifAbsent: [ #() ]) flattened
				asAsyncStream
				collect: [ :each | 
					each
						-> (each node completeSource asString asUppercase allRangesOfSubstring: string) ])
				select: [ :each | each value notEmpty ])
				collect: [ :each | 
					each value asAsyncStream
						collect: [ :interval | 
							(each key node nodeForInterval: interval)
								ifNil: [ each key ]
								ifNotNil: [ :node | self lookupEntityForNode: node ] ] ]) flatten
				withoutDuplicates ];
		itemName: #name
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
	^ GtLZAEditorImporter
		importFileNamed: aFileReference
		source: aString
		into: self
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

{ #category : #private }
GtLZAEditorModel >> lookupEntityForNode: node [
	| current |
	current := node.
	[ (current attributeNamed: #entity) ifNotNil: [ :entity | ^ entity ].
	current := current parent ] repeat
]

{ #category : #accessing }
GtLZAEditorModel >> privateEntityNamed: aString ofType: aClass [
	^ self entities
		at: aClass
		ifPresent: [ :dict | 
			dict
				at: aString
				ifPresent: [ :col | col at: 1 ifAbsent: [  ] ]
				ifAbsent: [  ] ]
		ifAbsent: [  ]
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
	(self privateEntityNamed: name ofType: GtLZAEditorFile)
		ifNotNil: [ :file | file entities do: [ :each | self removeEntity: each ] ].
	updates at: aFileReference put: aString
]
