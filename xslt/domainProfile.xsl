<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:cl="http://www.opentext.org/ns/clause" xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink"

xmlns:xalan="http://xml.apache.org/xalan"

>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	

	<xsl:param name="start"/>
	<xsl:param name="end"/>
	<xsl:param name="show">single</xsl:param>

	<xsl:variable name="startClause">
		<xsl:choose>
			<xsl:when test="number($start)&gt;0"><xsl:value-of select="$start"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="substring-after(//cl:clause[parent::chapter][1]/@id,'_')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="endClause">
		<xsl:choose>
			<xsl:when test="number($end)&gt;0"><xsl:value-of select="$end"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="substring-after(//cl:clause[parent::chapter][position()=last()]/@id,'_')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>


		

	<xsl:variable name="domains">
	<domains>
	<domain num="1">Geographical Objects and Features</domain>
	<domain num="2">Natural Substances</domain>
	<domain num="3">Plants</domain>
	<domain num="4">Animals</domain>
	<domain num="5">Foods and Condiments</domain>
	<domain num="6">Artifacts</domain>
	<domain num="7">Constructions</domain>
	<domain num="8">Body, Body Parts, and Body Products</domain>
	<domain num="9">People</domain>
	<domain num="10">Kinship Terms</domain>
	<domain num="11">Groups and Classes of Persons and Members of Such Groups and Classes</domain>
	<domain num="12">Supernatural Beings and Powers</domain>
	<domain num="13">Be, Become, Exist, Happen</domain>
	<domain num="14">Physical Events and States</domain>
	<domain num="15">Linear Movement</domain>
	<domain num="16">Non-Linear Movement</domain>
	<domain num="17">Stances and Events Related to Stances</domain>
	<domain num="18">Attachment</domain>
	<domain num="19">Physical Impact</domain>
	<domain num="20">Violence, Harm, Destroy, Kill</domain>
	<domain num="21">Danger, Risk, Safe, Save</domain>
	<domain num="22">Trouble, Hardship, Relief, Favorable Circumstances</domain>
	<domain num="23">Physiological Processes and States</domain>
	<domain num="24">Sensory Events and States</domain>
	<domain num="25">Attitudes and Emotions</domain>
	<domain num="26">Psychological Faculties</domain>
	<domain num="27">Learn</domain>
	<domain num="28">Know</domain>
	<domain num="29">Memory and Recall</domain>
	<domain num="30">Think</domain>
	<domain num="31">Hold a View, Believe, Trust</domain>
	<domain num="32">Understand</domain>
	<domain num="33">Communication</domain>
	<domain num="34">Association</domain>
	<domain num="35">Help, Care For</domain>
	<domain num="36">Guide, Discipline, Follow</domain>
	<domain num="37">Control, Rule</domain>
	<domain num="38">Punish, Reward</domain>
	<domain num="39">Hostility, Strife</domain>
	<domain num="40">Reconciliation, Forgiveness</domain>
	<domain num="41">Behavior and Related States</domain>
	<domain num="42">Perform, Do</domain>
	<domain num="43">Agriculture</domain>
	<domain num="44">Animal Husbandry, Fishing</domain>
	<domain num="45">Building, Constructing</domain>
	<domain num="46">Household Activities</domain>
	<domain num="47">Activities Involving Liquids or Masses</domain>
	<domain num="48">Activities Involving Cloth</domain>
	<domain num="49">Activities Involving Clothing and Adorning</domain>
	<domain num="50">Contests and Play</domain>
	<domain num="51">Festivals</domain>
	<domain num="52">Funerals and Burial</domain>
	<domain num="53">Religious Activities</domain>
	<domain num="54">Maritime Activities</domain>
	<domain num="55">Military Activities</domain>
	<domain num="56">Courts and Legal Procedures</domain>
	<domain num="57">Possess, Transfer, Exchange</domain>
	<domain num="58">Nature, Class, Example</domain>
	<domain num="59">Quantity</domain>
	<domain num="60">Number</domain>
	<domain num="61">Sequence</domain>
	<domain num="62">Arrange, Organize</domain>
	<domain num="63">Whole, Unite, Part, Divide</domain>
	<domain num="64">Comparison</domain>
	<domain num="65">Value</domain>
	<domain num="66">Proper, Improper</domain>
	<domain num="67">Time</domain>
	<domain num="68">Aspect</domain>
	<domain num="69">Affirmation, Negation</domain>
	<domain num="70">Real, Unreal</domain>
	<domain num="71">Mode</domain>
	<domain num="72">True, False</domain>
	<domain num="73">Genuine, Phony</domain>
	<domain num="74">Able, Capable</domain>
	<domain num="75">Adequate, Qualified</domain>
	<domain num="76">Power, Force</domain>
	<domain num="77">Ready, Prepared</domain>
	<domain num="78">Degree</domain>
	<domain num="79">Features of Objects</domain>
	<domain num="80">Space</domain>
	<domain num="81">Spacial Dimensions</domain>
	<domain num="82">Spacial Orientations</domain>
	<domain num="83">Spacial Positions</domain>
	<domain num="84">Spacial Extensions</domain>
	<domain num="85">Existence in Space</domain>
	<domain num="86">Weight</domain>
	<domain num="87">Status</domain>
	<domain num="88">Moral and Ethical Qualities and Related Behavior</domain>
	<domain num="89">Relations</domain>
	<domain num="90">Case</domain>
	<domain num="91">Discourse Markers</domain>
	<domain num="92">Discourse Referentials</domain>
	<domain num="93">Names of Persons and Places</domain>
</domains>

	
	</xsl:variable>
	
	
	<xsl:template match="/">
	
		<xsl:variable name="profile">
		<semanticProfile>
	
		<columns>
		<xsl:for-each select="//cl:clause[parent::chapter][number(substring-after(@id,'_'))&gt;=$startClause and number(substring-after(@id,'_'))&lt;=$endClause]//w[child::*[1][starts-with(name(),'VB') or self::NON or starts-with(name(),'AD')]]">
				<xsl:choose>
				<!-- SHOW JUST A SINGLE DOMAIN -->
					<xsl:when test="$show='single'">
	<xsl:variable name="dom">
					<xsl:choose>
						<xsl:when test="sem/*[@select]">
							<xsl:value-of select="sem/*[@select]/@majorNum"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="sem/*[1]/@majorNum"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:if test="not(preceding::w[child::*[1][starts-with(name(),'VB') or self::NON or starts-with(name(),'AD')]]/sem/*[@select]/@majorNum = $dom or preceding::w[child::*[1][starts-with(name(),'VB') or self::NON or starts-with(name(),'AD')]]/sem/*[1]/@majorNum = $dom)">
					<col dom="{$dom}"/>
				</xsl:if>
					
					
					</xsl:when>
					<xsl:otherwise>
						<!-- SHOW ALL DOMAINS -->
					<xsl:for-each select="sem/*">
						<xsl:variable name="dom">
								<xsl:value-of select="@majorNum"/>
				</xsl:variable>

				<xsl:if test="not(preceding::w[child::*[1][starts-with(name(),'VB') or self::NON or starts-with(name(),'AD')]]/sem/*/@majorNum = $dom)">
					<col dom="{$dom}"/>
				</xsl:if>
											</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			
		</xsl:for-each>
		</columns>
	
	
		<semantic_chains>
			<xsl:for-each select="//cl:clause[parent::chapter][number(substring-after(@id,'_'))&gt;=$startClause and number(substring-after(@id,'_'))&lt;=$endClause]">
				<xsl:variable name="id" select="@id"/>
				<unit id="{substring-after($id,'.')}">
		
					<xsl:for-each select=".//w[child::*[1][starts-with(name(),'VB') or self::NON or starts-with(name(),'AD')]]">
						<xsl:variable name="dom">
							<xsl:choose>
								<xsl:when test="sem/*[@select]">
									<xsl:value-of select="sem/*[@select]/@majorNum"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="sem/*[1]/@majorNum"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:if test="not(preceding::w[ancestor::cl:clause[@id=$id]][child::*[1][starts-with(name(),'VB') or self::NON or starts-with(name(),'AD')]]/sem/*[@select]/@majorNum = $dom or preceding::w[ancestor::cl:clause[@id=$id]][child::*[1][starts-with(name(),'VB') or self::NON or starts-with(name(),'AD')]]/sem/*[1]/@majorNum = $dom)">
							
								<dom num="{$dom}"><xsl:value-of select="count(ancestor::cl:clause[@id=$id]//w[child::*[1][starts-with(name(),'VB') or self::NON or starts-with(name(),'AD')]][sem/*/@majorNum = $dom])"/></dom>

						</xsl:if>

					</xsl:for-each>		
				
				</unit>
		
			</xsl:for-each>
		</semantic_chains>
		
		</semanticProfile>
		</xsl:variable>
		
		<html>
			<head>
				<title>Semantic Profile</title>
			
	      <style type="text/css">
          table { border-collapse: collapse; border-spacing: 0;
      font-family: Arial; font-size: 8pt;
      }
      
      td, th { border: 1px #e0e0e0 dotted; text-align: center;}
      
      th { padding: 2px;}
      
      .summary { margin-top: 20px;}
      
      .summary td, .summary th { border: 1px black solid; vertical-align: top;}
      
      .domain-col { width: 40%; text-align: left; padding-left: 4pt }
      
     
            
      </style>			
				
			</head>
			<body>
		<!--	<h1>start <xsl:value-of select="$startClause"/>  end <xsl:value-of select="$endClause"/></h1> -->
			<table>
				<thead>
					<tr>
						<th>Clause</th>
						<xsl:for-each select="xalan:nodeset($profile)//columns/col">
						<th><xsl:value-of select="@dom"/></th>
						</xsl:for-each>
					</tr>
				</thead>
				<tbody>
				 
					
					<xsl:for-each select="xalan:nodeset($profile)//unit">
						<xsl:variable name="id" select="@id"/>
						<tr>
							<td><xsl:value-of select="$id"/></td>
							<xsl:for-each select="xalan:nodeset($profile)//columns/col">
								<td>
								<xsl:if test="xalan:nodeset($profile)//unit[@id=$id]/dom/@num = current()/@dom">
									<xsl:value-of select="xalan:nodeset($profile)//unit[@id=$id]/dom[@num = current()/@dom]"/>
								</xsl:if>
								</td>
							</xsl:for-each>
						</tr>
					</xsl:for-each>
					
				</tbody>
				
				<tfoot>
					<tr>
						<th>Clause</th>
						<xsl:for-each select="xalan:nodeset($profile)//columns/col">
						<th><xsl:value-of select="@dom"/></th>
						</xsl:for-each>
					</tr>
				</tfoot>
			</table>
			
			<table class="summary">
			
					
				<tbody>
					<tr>
						<th class="domain-col">Domain</th>
						<th>freq.</th>
						<th class="domain-col">Domain</th>
						<th>freq.</th>
					</tr>
					
					<xsl:variable name="orderedDomains">
					<xsl:for-each select="xalan:nodeset($profile)//columns/col">
						<xsl:sort select="number(sum(xalan:nodeset($profile)//dom[@num=current()/@dom]))" data-type="number" order="descending"/>
						<xsl:copy-of select="."/>
					</xsl:for-each>
					
					</xsl:variable>
						
						 
						
					<xsl:for-each select="xalan:nodeset($orderedDomains)//col[position()&lt;= (last() div 2)]">	
						
						 
						<tr>
							<td class="domain-col"><xsl:value-of select="@dom"/><xsl:text> </xsl:text>
								<xsl:value-of select="xalan:nodeset($domains)//domain[@num=current()/@dom]"/>
							</td>
							<td><xsl:value-of select="sum(xalan:nodeset($profile)//dom[@num=current()/@dom])"/></td>
							
							<xsl:variable name="cpos" select="position()"/>
							<xsl:variable name="next-dom" select="xalan:nodeset($orderedDomains)/col[position()=$cpos+round(last() div 2)]/@dom"/>
							
							<td class="domain-col"><xsl:value-of select="$next-dom"/><xsl:text> </xsl:text>
								<xsl:value-of select="xalan:nodeset($domains)//domain[@num=$next-dom]"/>
							</td>
							<td><xsl:value-of select="sum(xalan:nodeset($profile)//dom[@num=$next-dom])"/></td>

							
							 
						</tr>
						
				 
					</xsl:for-each>
					
				</tbody>
			</table>
			
			</body>
		</html>
		
	</xsl:template>
	
</xsl:stylesheet>
