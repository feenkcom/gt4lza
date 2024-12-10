Class {
	#name : #GtLZAImporter,
	#superclass : #Object,
	#instVars : [
		'directory',
		'accounts',
		'metadata',
		'organizationalUnits',
		'policies'
	],
	#category : #'Gt4LZA-Importer'
}

{ #category : #accessing }
GtLZAImporter >> directory [
	^ directory
]

{ #category : #accessing }
GtLZAImporter >> directory: anObject [
	directory := anObject
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtAccountsFor: aView [
	<gtView>
	^ aView forward
		title: 'Accounts';
		priority: 1;
		object: [ accounts ];
		view: #gtAccountsFor:
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtMetadataFor: aView [
	"this is a copy of Dictionary>>#gtItemsFor: that expandsAll by default and only displays the value if it’s not expandable"

	<gtView>
	^ aView columnedTree
		title: 'Meta data';
		priority: 5;
		items: [ self metadata associations sort: (#key collatedBy: #asString) ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations sort: (#key collatedBy: #asString) ]
				ifFalse: [ (each value isCollection and: [ each value isString not ])
						ifTrue: [ each value collect: [ :x | x -> '' ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: [ :assoc | assoc key ];
		column: 'Value'
			text: [ :assoc | 
				(assoc value isDictionary
					or: [ assoc value isCollection and: [ assoc value isString not ] ])
					ifTrue: [ '' ]
					ifFalse: [ assoc value ] ]
			weight: 3;
		contextItemLabel: 'Inspect key'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value key ];
		contextItemLabel: 'Inspect association'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value ];
		send: [ :assoc | assoc value ];
		expandUpTo: 1
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtOrganizationalUnitsFor: aView [
	<gtView>
	^ aView forward
		title: 'Organizational units';
		priority: 2;
		object: [ organizationalUnits ];
		view: #gtOrganizationalUnitsFor:
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> gtPoliciesFor: aView [
	<gtView>
	^ aView forward
		title: 'Policies';
		priority: 3;
		object: [ policies ];
		view: #gtPoliciesFor:
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> import [
	self assert: directory isNotNil description: 'Import directory must be set'.
	self assert: directory exists description: 'Import directory must exist'.
	
	self importOrganization.
	self importAccounts.
	self importNetwork
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> importAccounts [
	| file yaml |
	file := directory / 'accounts-config.yaml'.

	file
		ifExists: [ yaml := YAMLParser parseFile: file.
			yaml object
				keysAndValuesDo: [ :aKey :aList | 
					aList
						do: [ :anAccount | 
							accounts
								add: (GtLZAAccount new
										name: (anAccount at: 'name');
										description: (anAccount at: 'description');
										email: (anAccount at: 'email');
										organizationalUnit: (organizationalUnits findNamed: (anAccount at: 'organizationalUnit'));
										type: aKey) ] ] ]
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> importNetwork [
	| file yaml |
	file := directory / 'network-config.yaml'.
	yaml := (YAMLParser parseFile: file) object.

	self metadata at: 'Home region' put: (yaml at: 'homeRegion').
	
	self metadata at: 'Default VPC' put: (yaml at: 'defaultVpc').
	
	self metadata at: 'VPC Flow Logs' put: (yaml at: 'vpcFlowLogs')
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> importOrganization [
	| file object |
	file := directory / 'organization-config.yaml'.

	file
		ifExists: [ object := (YAMLParser parseFile: file) object.
			self metadata at: 'Organization enabled' put: (object at: 'enable').

			(object at: 'organizationalUnits')
				do: [ :anOu | organizationalUnits add: (GtLZAOrganizationalUnit new name: (anOu at: 'name')) ].

			{'serviceControlPolicies'.
				'taggingPolicies'.
				'backupPolicies'}
				do: [ :aPolicyKey | 
					(object at: aPolicyKey)
						do: [ :aPolicy | 
							policies
								add: (GtLZAPolicy new
										name: (aPolicy at: 'name');
										description: (aPolicy at: 'description');
										policy: self directory / (aPolicy at: 'policy');
										type: (aPolicy at: 'type' ifAbsent: [ '' ]);
										organizationalUnits: ((aPolicy at: 'deploymentTargets' at: 'organizationalUnits')
												collect: [ :aName | organizationalUnits findNamed: aName ])) ] ] ]
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> initialize [
	accounts := GtLZAAccountsGroup new.
	organizationalUnits := GtLZAOrganizationalUnitsGroup new.
	policies := GtLZAPoliciesGroup new.
	
	metadata := Dictionary new
]

{ #category : #'as yet unclassified' }
GtLZAImporter >> metadata [
	^ metadata
]
