#!/bin/bash

cli-name=$1
cli-pass=$2

cat <<EOF | java -jar /var/jenkins_home/jars/jenkins-cli.jar -s http://localhost:8080 -auth ${cli-name}:${cli-pass} create-node
<slave>
  <name>private</name>
  <description>automatically added node</description>
  <remoteFS></remoteFS>
  <numExecutors>1</numExecutors>
  <mode>EXCLUSIVE</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
  <launcher class="hudson.slaves.CommandLauncher" plugin="command-launcher@84.v4a_97f2027398">
    <agentCommand>ssh private</agentCommand>
  </launcher>
  <label>private</label>
  <nodeProperties>
    <hudson.slaves.EnvironmentVariablesNodeProperty>
      <envVars serialization="custom">
        <unserializable-parents/>
        <tree-map>
          <default>
            <comparator class="java.lang.String$CaseInsensitiveComparator"/>
          </default>
          <int>3</int>
          <string>env1</string>
          <string>val1</string>
          <string>env2</string>
          <string>val2</string>
          <string>env3</string>
          <string>val3</string>
        </tree-map>
      </envVars>
    </hudson.slaves.EnvironmentVariablesNodeProperty>
  </nodeProperties>
</slave>
EOF
