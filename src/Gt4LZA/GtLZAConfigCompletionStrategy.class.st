Class {
	#name : #GtLZAConfigCompletionStrategy,
	#superclass : #GtYAMLCompletionStrategy,
	#instVars : [
		'model'
	],
	#classInstVars : [
		'fileCompleters'
	],
	#category : #'Gt4LZA-Completion'
}

{ #category : #private }
GtLZAConfigCompletionStrategy class >> accountsConfig [
	^ '
mandatoryAccounts: 
  - 
    organizationalUnit: <organizationalUnit>?
workloadAccounts: 
  - 
    organizationalUnit: <organizationalUnit>?
'
]

{ #category : #'instance creation' }
GtLZAConfigCompletionStrategy class >> forAccountsConfig [
	^ self new
		loadCompleterFrom: self accountsConfig;
		yourself
]

{ #category : #'instance creation' }
GtLZAConfigCompletionStrategy class >> forFileType: aString [
	| completer strategy fileCompleter |
	strategy := aString = 'accounts-config.yaml'
			ifTrue: [ self forAccountsConfig ]
			ifFalse: [ aString = 'organization-config.yaml'
					ifTrue: [ self forOrganizationConfig ]
					ifFalse: [ aString = 'network-config.yaml'
							ifTrue: [ self forNetworkConfig ]
							ifFalse: [ self new ] ] ].
	completer := (fileCompleters ifNil: [ fileCompleters := Dictionary new ])
			at: aString
			ifAbsentPut: [ self loadCompleterForFileType: aString ].
	completer := strategy completer merge: completer.
	fileCompleter := GtYAMLKeyMatchCompleter new defaultCompleter: completer.
	#('policy' 'document' 'rolePolicyFile' 'dynamicPartitioning')
		do: [ :each | 
			fileCompleter
				add: (GtYAMLBlockCompleter new
						name: '<jsonFiles>';
						block: [ :string :pos | 
							strategy
								findCompletionsOf: string
								at: pos
								withValuesFrom: '<jsonFiles>' ])
				forKey: each ].
	#('template')
		do: [ :each | 
			fileCompleter
				add: (GtYAMLBlockCompleter new
						name: '<yamlFiles>';
						block: [ :string :pos | 
							strategy
								findCompletionsOf: string
								at: pos
								withValuesFrom: '<yamlFiles>' ])
				forKey: each ].
	strategy completer: fileCompleter.
	^ strategy
]

{ #category : #'instance creation' }
GtLZAConfigCompletionStrategy class >> forNetworkConfig [
	^ self new
		loadCompleterFrom: self networkConfig;
		yourself
]

{ #category : #'instance creation' }
GtLZAConfigCompletionStrategy class >> forOrganizationConfig [
	^ self new
		loadCompleterFrom: self organizationConfig;
		yourself
]

{ #category : #private }
GtLZAConfigCompletionStrategy class >> loadCompleterForFileType: aString [
	(aString endsWith: '-config.yaml') ifFalse: [ ^ GtYAMLEmptyCompleter instance ].
	^ [ | type json jsonObject schema |
	type := aString allButLast: 12.
	json := ZnClient new
			url: 'https://raw.githubusercontent.com/awslabs/landing-zone-accelerator-on-aws/refs/heads/main/source/packages/%40aws-accelerator/config/lib/schemas/'
					, type , '-config.json';
			get.
	jsonObject := NeoJSONObject fromString: json.
	schema := NeoJSONSchema new json: jsonObject.
	GtYAMLCompleter forJSONSchema: (schema resolveSubSchema: schema raw) ]
		on: Error
		do: [ :ex | ex return: GtYAMLEmptyCompleter instance ]
]

{ #category : #private }
GtLZAConfigCompletionStrategy class >> networkConfig [
	^ '
centralNetworkServices: 
  ipams: 
    - 
      pools: 
        - 
          shareTargets: 
            accounts: 
              - <account>?
            organizationalUnits: 
              - <organizationalUnit>?
  networkFirewall: 
    policies: 
      - 
        shareTargets: 
          accounts: 
            - <account>?
          organizationalUnits: 
            - <organizationalUnit>?
    rules: 
      - 
        shareTargets: 
          accounts: 
            - <account>?
          organizationalUnits: 
            - <organizationalUnit>?
  route53Resolver: 
    endpoints: 
      - 
        rules: 
          - 
            shareTargets: 
              accounts: 
                - <account>?
              organizationalUnits: 
                - <organizationalUnit>?
    firewallRuleGroups: 
      - 
        shareTargets: 
          accounts: 
            - <account>?
          organizationalUnits: 
            - <organizationalUnit>?
    queryLogs: 
      shareTargets: 
        accounts: 
          - <account>?
        organizationalUnits: 
          - <organizationalUnit>?
    rules: 
      - 
        shareTargets: 
          accounts: 
            - <account>?
          organizationalUnits: 
            - <organizationalUnit>?
certificates: 
  - 
    deploymentTargets: 
      accounts: 
        - <account>?
      excludedAccounts: 
        - <account>?
      excludedRegions: 
        - 
      organizationalUnits: 
        - <organizationalUnit>?
customerGateways: 
  - 
    account: <account>?
defaultVpc: 
  excludeAccounts: 
    - <account>?
dhcpOptions: 
  - 
    accounts: 
      - <account>?
directConnectGateways: 
  - 
    account: <account>?
    transitGatewayAssociations: 
      - 
        account: <account>?
elbAccountIds: 
  - 
    region: 
prefixLists: 
  - 
    accounts: 
      - <account>?
    deploymentTargets: 
      accounts: 
        - <account>?
      excludedAccounts: 
        - <account>?
      excludedRegions: 
        - 
      organizationalUnits: 
        - <organizationalUnit>?
transitGateways: 
  - 
    account: <account>?
    shareTargets: 
      accounts: 
        - <account>?
      organizationalUnits: 
        - <organizationalUnit>?
vpcPeering: 
  - 
    vpcs: 
      - <vpc>?
vpcTemplates: 
  - 
    deploymentTargets: 
      accounts: 
        - <account>?
      excludedAccounts: 
        - <account>?
      excludedRegions: 
        - 
      organizationalUnits: 
        - <organizationalUnit>?
    interfaceEndpoints: 
      subnets: 
        - 
    loadBalancers: 
      applicationLoadBalancers: 
        - 
          shareTargets: 
            accounts: 
              - <account>?
            organizationalUnits: 
              - <organizationalUnit>?
          subnets: 
            - 
      networkLoadBalancers: 
        - 
          subnets: 
            - 
    natGateways: 
      - 
        subnet: 
    subnets: 
      - 
        shareTargets: 
          accounts: 
            - <account>?
          organizationalUnits: 
            - <organizationalUnit>?
    targetGroups: 
      - 
        shareTargets: 
          accounts: 
            - <account>?
          organizationalUnits: 
            - <organizationalUnit>?
    transitGatewayAttachments: 
      - 
        subnets: 
          - 
vpcs: 
  - 
    account: <account>?
    interfaceEndpoints: 
      subnets: 
        - 
    loadBalancers: 
      applicationLoadBalancers: 
        - 
          shareTargets: 
            accounts: 
              - <account>?
            organizationalUnits: 
              - <organizationalUnit>?
          subnets: 
            - 
      networkLoadBalancers: 
        - 
          subnets: 
            - 
    subnets: 
      - 
        shareTargets: 
          accounts: 
            - <account>?
          organizationalUnits: 
            - <organizationalUnit>?
    targetGroups: 
      - 
        shareTargets: 
          accounts: 
            - <account>?
          organizationalUnits: 
            - <organizationalUnit>?
    transitGatewayAttachments: 
      - 
        subnets: 
          - 
    vpcRoute53Resolver: 
      endpoints: 
        - 
          rules: 
            - 
              shareTargets: 
                accounts: 
                  - <account>?
                organizationalUnits: 
                  - <organizationalUnit>?
          subnets: 
            - 
          vpc: <vpc>?
      firewallRuleGroups: 
        - 
          shareTargets: 
            accounts: 
              - <account>?
            organizationalUnits: 
              - <organizationalUnit>?
      queryLogs: 
        shareTargets: 
          accounts: 
            - <account>?
          organizationalUnits: 
            - <organizationalUnit>?
      rules: 
        - 
          shareTargets: 
            accounts: 
              - <account>?
            organizationalUnits: 
              - <organizationalUnit>?
'
]

{ #category : #private }
GtLZAConfigCompletionStrategy class >> organizationConfig [
	^ '
backupPolicies: 
  - 
    deploymentTargets: 
      accounts: 
        - <account>?
      excludedAccounts: 
        - <account>?
      excludedRegions: 
        - 
      organizationalUnits: 
        -  <organizationalUnit>?
chatbotPolicies: 
  - 
    deploymentTargets: 
      accounts: 
        - <account>?
      excludedAccounts: 
        - <account>?
      excludedRegions: 
        - 
      organizationalUnits: 
        -  <organizationalUnit>?
serviceControlPolicies: 
  - 
    deploymentTargets: 
      accounts: 
        - <account>?
      excludedAccounts: 
        - <account>?
      excludedRegions: 
        - 
      organizationalUnits: 
        - <organizationalUnit>?
taggingPolicies: 
  - 
    deploymentTargets: 
      accounts: 
        - <account>?
      excludedAccounts: 
        - <account>?
      excludedRegions: 
        - 
      organizationalUnits: 
        - <organizationalUnit>?
'
]

{ #category : #accessing }
GtLZAConfigCompletionStrategy >> model [
	^ model
]

{ #category : #accessing }
GtLZAConfigCompletionStrategy >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
GtLZAConfigCompletionStrategy >> potentialValuesOf: aString forLookup: nameString [
	| stream |
	stream := super potentialValuesOf: aString forLookup: nameString.
	model
		ifNotNil: [ nameString = '<organizationalUnit>'
				ifTrue: [ ^ ((model allOrganizationalUnitNames asSortedCollection asAsyncStream
						select: [ :each | each beginsWith: aString ]) merge: stream)
						withoutDuplicates ].
			nameString = '<account>'
				ifTrue: [ ^ ((model allAccountNames asSortedCollection asAsyncStream
						select: [ :each | each beginsWith: aString ]) merge: stream)
						withoutDuplicates ].
			nameString = '<vpc>'
				ifTrue: [ ^ ((model allVPCNames asSortedCollection asAsyncStream
						select: [ :each | each beginsWith: aString ]) merge: stream)
						withoutDuplicates ].
			nameString = '<jsonFiles>'
				ifTrue: [ ^ ((model allFileNames asSortedCollection asAsyncStream
						select: [ :each | (each beginsWith: aString) and: [ each endsWith: '.json' ] ])
						merge: stream) withoutDuplicates ].
			nameString = '<yamlFiles>'
				ifTrue: [ ^ ((model allFileNames asSortedCollection asAsyncStream
						select: [ :each | (each beginsWith: aString) and: [ each endsWith: '.yaml' ] ])
						merge: stream) withoutDuplicates ] ].
	^ stream
]
