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
GtLZAImporter >> gtMetaDataFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Meta data';
		priority: 5;
		items: [self metadata associations];
		column: 'Key' text: #key;
		column: 'Value' text: #value
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
	self importAccounts
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
