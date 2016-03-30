<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:z="https://github.com/Conal-Tuohy/XProc-Z"
xmlns:corbicula="tag:conaltuohy.com,2015:corbicula"
version="1.0" name="main">

	<p:input port='source' primary='true'/>	
	<p:input port='parameters' kind='parameter' primary='true'/>
	<p:output port="result" primary="true" sequence="true"/>
	<p:import href="xproc-z-library.xpl"/>
	<p:import href="oai-pmh/harvest.xpl"/>
	<corbicula:handle-harvest-request/>

</p:declare-step>
