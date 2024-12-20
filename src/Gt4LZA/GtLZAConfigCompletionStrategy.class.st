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
<account>:
  - name: <accountName>?
    description: 
    email: 
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
	| completer selector |
	completer := (fileCompleters ifNil: [ fileCompleters := Dictionary new ])
			at: aString
			ifAbsentPut: [ self loadCompleterForFileType: aString ].
	completer = GtYAMLEmptyCompleter instance
		ifTrue: [ selector := ('for' , (aString allButLast: (12 min: aString size)) capitalized
					, 'Config') asSymbol.
			(self respondsTo: selector) ifTrue: [ ^ self perform: selector ] ].
	^ self new
		completer: completer;
		yourself
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
homeRegion: <homeRegion>
defaultVpc:
  delete: true,false
  excludeAccounts: - <accountName>?
transitGateways:
  - name: <transitGateway>?
    account: <accountName>?
    region: 
    shareTargets:
      organizationalUnits:
        - <organizationalUnit>?
    asn: 
    dnsSupport: enable,disable
    vpnEcmpSupport: enable,disable
    defaultRouteTableAssociation: enable,disable
    defaultRouteTablePropagation: enable,disable
    autoAcceptSharingAttachments: enable,disable
    routeTables:
      - name: <routeTable>
        routes: - 
centralNetworkServices:
  delegatedAdminAccount: <accountName>?
  networkFirewall:
    firewalls:
      - name: <firewallName>
        firewallPolicy: <firewallPolicy>?
        subnets:
          - <subnetName>?
        vpc: <vpcName>?
        loggingConfiguration:
          - destination: 
            type: 
    policies:
      - name: <policyName>
        regions:
          - 
        firewallPolicy:
          statelessDefaultActions: -
          statelessFragmentDefaultActions: -
          statefulRuleGroups:
            - name: 
        shareTargets:
          organizationalUnits:
            - <organizationalUnit>?
    rules:
      - name: 
        regions:
          - 
        capacity: 
        type: 
        ruleGroup:
          rulesSource:
            statefulRules:
              - action: 
                header:
                  destination: 
                  destinationPort: 
                  direction: 
                  protocol: 
                  source: 
                  sourcePort: 
                ruleOptions:
                  - keyword: 
                    settings: -
  route53Resolver:
    endpoints: -
    queryLogs:
      name: 
      destinations:
        - 
      shareTargets:
        organizationalUnits:
          - <organizationalUnit>?
    firewallRuleGroups:
      - name: 
        regions:
          - 
        rules:
          - name: 
            action: 
            managedDomainList: 
            priority: 
            blockResponse: 
        shareTargets:
          organizationalUnits:
            - <organizationalUnit>?
endpointPolicies:
  - name: 
    document: 
vpcs:
  - name: <vpcName>
    account: <accountName>?
    region: 
    cidrs:
      - 
    internetGateway: true,false
    enableDnsHostnames: true,false
    enableDnsSupport: true,false
    instanceTenancy: 
    queryLogs:
      - 
    routeTables:
      - name: <routeTableName>
        routes: -
    subnets:
      - name: <subnetName>
        availabilityZone: 
        routeTable: <routeTableName>?
        ipv4CidrBlock: 
    transitGatewayAttachments:
      - name: <transitGatewayAttachmentName>
        transitGateway:
          name: <transitGatewayName>
          account: <accountName>?
        routeTableAssociations:
          - <routeTableAssociationName>
        routeTablePropagations:
          - <routeTablePropagationName>
        subnets:
          - <subnetName>?
    gatewayEndpoints:
      defaultPolicy: 
      endpoints:
        - service: 
    interfaceEndpoints:
      central: true,false
      defaultPolicy: 
      subnets:
        - <subnetName>?
      endpoints:
        - service: 
vpcFlowLogs:
  trafficType: 
  maxAggregationInterval: 
  destinations:
    - 
  destinationsConfig:
    cloudWatchLogs:
      retentionInDays: 
  defaultFormat: true,false
  customFields:
    - 
'
]

{ #category : #private }
GtLZAConfigCompletionStrategy class >> organizationConfig [
	^ '
enable: true,false
organizationalUnits:
  - name: <organizationalUnit>
serviceControlPolicies:
  - name: 
    description: 
    policy: 
    type: 
    deploymentTargets:
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
				ifTrue: [ stream := (((model allLZAOrganizationalUnits collect: #name) asArray
							asAsyncStream select: [ :each | each beginsWith: aString ]) merge: stream)
							withoutDuplicates ] ].
	^ stream
]
