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
	| completer strategy |
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
	strategy completer: (strategy completer merge: completer).
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
              - 
            organizationalUnits: 
              - <organizationalUnit>?
  networkFirewall: 
    policies: 
      - 
        shareTargets: 
          accounts: 
            - 
          organizationalUnits: 
            - <organizationalUnit>?
    rules: 
      - 
        shareTargets: 
          accounts: 
            - 
          organizationalUnits: 
            - <organizationalUnit>?
  route53Resolver: 
    endpoints: 
      - 
        rules: 
          - 
            shareTargets: 
              accounts: 
                - 
              organizationalUnits: 
                - <organizationalUnit>?
    firewallRuleGroups: 
      - 
        shareTargets: 
          accounts: 
            - 
          organizationalUnits: 
            - <organizationalUnit>?
    queryLogs: 
      shareTargets: 
        accounts: 
          - 
        organizationalUnits: 
          - <organizationalUnit>?
    rules: 
      - 
        shareTargets: 
          accounts: 
            - 
          organizationalUnits: 
            - <organizationalUnit>?
certificates: 
  - 
    deploymentTargets: 
      accounts: 
        - 
      excludedAccounts: 
        - 
      excludedRegions: 
        - 
      organizationalUnits: 
        - <organizationalUnit>?
customerGateways: 
  - 
    account: 
defaultVpc: 
  excludeAccounts: 
    - 
dhcpOptions: 
  - 
    accounts: 
      - 
directConnectGateways: 
  - 
    account: 
    transitGatewayAssociations: 
      - 
        account: 
elbAccountIds: 
  - 
    region: 
prefixLists: 
  - 
    accounts: 
      - 
    deploymentTargets: 
      accounts: 
        - 
      excludedAccounts: 
        - 
      excludedRegions: 
        - 
      organizationalUnits: 
        - <organizationalUnit>?
transitGateways: 
  - 
    account: 
    shareTargets: 
      accounts: 
        - 
      organizationalUnits: 
        - <organizationalUnit>?
vpcPeering: 
  - 
    vpcs: 
      - 
vpcTemplates: 
  - 
    deploymentTargets: 
      accounts: 
        - 
      excludedAccounts: 
        - 
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
              - 
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
            - 
          organizationalUnits: 
            - <organizationalUnit>?
    targetGroups: 
      - 
        shareTargets: 
          accounts: 
            - 
          organizationalUnits: 
            - <organizationalUnit>?
    transitGatewayAttachments: 
      - 
        subnets: 
          - 
vpcs: 
  - 
    account: 
    interfaceEndpoints: 
      subnets: 
        - 
    loadBalancers: 
      applicationLoadBalancers: 
        - 
          shareTargets: 
            accounts: 
              - 
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
            - 
          organizationalUnits: 
            - <organizationalUnit>?
    targetGroups: 
      - 
        shareTargets: 
          accounts: 
            - 
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
                  - 
                organizationalUnits: 
                  - <organizationalUnit>?
          subnets: 
            - 
          vpc: 
      firewallRuleGroups: 
        - 
          shareTargets: 
            accounts: 
              - 
            organizationalUnits: 
              - <organizationalUnit>?
      queryLogs: 
        shareTargets: 
          accounts: 
            - 
          organizationalUnits: 
            - <organizationalUnit>?
      rules: 
        - 
          shareTargets: 
            accounts: 
              - 
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
        - 
      excludedAccounts: 
        - 
      excludedRegions: 
        - 
      organizationalUnits: 
        -  <organizationalUnit>?
chatbotPolicies: 
  - 
    deploymentTargets: 
      accounts: 
        - 
      excludedAccounts: 
        - 
      excludedRegions: 
        - 
      organizationalUnits: 
        -  <organizationalUnit>?
serviceControlPolicies: 
  - 
    deploymentTargets: 
      accounts: 
        - 
      excludedAccounts: 
        - 
      excludedRegions: 
        - 
      organizationalUnits: 
        - <organizationalUnit>?
taggingPolicies: 
  - 
    deploymentTargets: 
      accounts: 
        - 
      excludedAccounts: 
        - 
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
				ifTrue: [ stream := ((model allOrganizationalUnitNames asSortedCollection asAsyncStream
							select: [ :each | each beginsWith: aString ]) merge: stream)
							withoutDuplicates ] ].
	^ stream
]
