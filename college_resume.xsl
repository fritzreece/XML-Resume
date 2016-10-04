<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
[
	<!ENTITY ndash "&#8211;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- <xsl:include href="aux_functions.xsl"/> -->
	<xsl:import href="aux_templates.xsl"/>
	<xsl:template match="/resume">
		<html>
			<head>
				<!-- <link rel="stylesheet" type="text/css" href="resume2.css"/> -->
				<link rel="stylesheet" type="text/css" href="fritz_resume.css"/>
				<link href='http://fonts.googleapis.com/css?family=Syncopate|Roboto:300,300italic,700' rel='stylesheet' type='text/css'/>
    			<link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300,300italic,700' rel='stylesheet' type='text/css'/>
			</head>
			<body>
			    <div class="header">
			        <h1><xsl:apply-templates select="basic/name" mode="uppercase"/></h1>
			        <h3><xsl:value-of select="basic/email"/></h3>
			        <h3>(<xsl:value-of select="basic/phone/areacode"/>) <xsl:value-of select="basic/phone/number"/></h3><!-- 
			        <h3><xsl:value-of select="basic/address/street"/></h3>
			        <h3>
			        	<xsl:value-of select="basic/address/city"/>,
			        	<xsl:value-of select="basic/address/state"/>
			        	<xsl:if test="not(basic/address/state)">
			        		<xsl:value-of select="basic/address/country"/>
			        	</xsl:if>
			        	<xsl:text> </xsl:text>
			        	<xsl:value-of select="basic/address/zip"/>
			     	</h3> -->
			    </div>
			    <div class="main">
			        <div class="section" id="education">
		                <h2>Education</h2>
		                <xsl:apply-templates select="education"/>
			        </div>
			        <div class="section" id="skills">
			            <h2>Skills</h2>
			            <ul>
			                <xsl:apply-templates select="skills"/>
			            </ul>
			        </div>
			        <div class="section" id="experience">
			            <h2>Relevant Experience</h2>
			            <xsl:apply-templates select="workExperience/job[@relevant='true']"/>
			        </div>
			        
			        <div id="course">
			        	<h2>Relevant Coursework</h2>
			        	<ul>
				        	<xsl:for-each select="relevantCourse">
				        		<li><xsl:value-of select="."/></li>
				        	</xsl:for-each>
			        	</ul>
			        </div>
			        <div class="section" id="leadership">
			             <h2>Extracurricular Activities</h2>
			             <ul class="noBullet"><xsl:apply-templates select="activities"/></ul>
			        </div>
			    </div>
			    <footer>This resume was generated with XML and XSL. You can find the source at <a href="https://github.com/fritzreece/XML-Resume">https://github.com/fritzreece/XML-Resume</a></footer>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="job">
		<div>
            <ul class="noBullet">
                <li><strong><xsl:value-of select="institution/name"/></strong><span class='right'><xsl:apply-templates select="institution/address" mode="cityState"/></span></li>
                <li>
                	<em>
	                	<xsl:for-each select="title">
	                		<xsl:value-of select="."/>
	                		<xsl:if test="not(position()=last())">
	                			<xsl:text>, </xsl:text>
	                		</xsl:if>
	                	</xsl:for-each>
	                </em>
	                <span class='right'>
	                	<xsl:choose>
		            		<xsl:when test="time/date">
		            			<xsl:apply-templates select="time" mode="startToEnd"/>
		            		</xsl:when>
		            		<xsl:otherwise>
		            			<xsl:value-of select="time"/>
		            		</xsl:otherwise>
	            	</xsl:choose>
	            	</span>
            	</li>
            </ul>
        	<xsl:apply-templates select="description"/>
        </div>
	</xsl:template>


	<xsl:template match="description">
		<ul>
			<xsl:choose>
				<xsl:when test="item">
					<xsl:choose>
						<xsl:when test="not(item[1]=item[last()])">
							<xsl:for-each select="item">
								<li><xsl:value-of select="."/></li>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<li><xsl:value-of select="."/></li>
				</xsl:otherwise>
			</xsl:choose>
		</ul>
	</xsl:template>


	<xsl:template match="program">
        <ul class="noBullet">
            <li><span style="font-weight:700;"><xsl:value-of select="degree"/></span>
            	<span class='right'>
            		<xsl:choose>
	            		<xsl:when test="time/date">
	            			<xsl:apply-templates select="time" mode="monYear"/>
	            		</xsl:when>
	            		<xsl:otherwise>
	            			<xsl:value-of select="time"/>
	            		</xsl:otherwise>
	            	</xsl:choose>
            	</span>
            </li>
            <li>
            	<strong><xsl:value-of select="institution/name"/></strong>
            	<span class='right'>
            		<xsl:apply-templates select="institution/address" mode="cityState"/>
            	</span>
            </li>
            <xsl:if test="gpa">
            	<li>Cumulative GPA: <xsl:value-of select="gpa"/></li>
            </xsl:if>
        </ul>
    </xsl:template>

    <xsl:template match="activity">
    	<div>
            <!-- <ul class="noBullet"> -->
                <li><strong><xsl:value-of select="name"/></strong>, <em><xsl:value-of select="institution/name"/></em>
                    <span class="right"><xsl:apply-templates select="time" mode="startToEnd"/></span></li>
            <!-- </ul> -->
            <!-- <xsl:apply-templates select="description"/> -->
        </div>
    </xsl:template>

    <xsl:template match="time" mode="startToEnd">
		<xsl:apply-templates select="date[@type='startDate']" mode="monYear"/>
		<xsl:text> &ndash; </xsl:text>
		<xsl:choose>
			<xsl:when test="date[@type='endDate']">
				<xsl:apply-templates select="date[@type='endDate']" mode="monYear"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Present</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="category">
		<xsl:choose>
			<xsl:when test="skillLevel">
				<xsl:for-each select="skillLevel">
					<li>
						<xsl:value-of select="@name"/>
						<xsl:text> in </xsl:text>
						<xsl:apply-templates select="skill" mode="commaList"/>
					</li>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="skill[@type='descriptive']">
		<li><xsl:value-of select="."/></li>
	</xsl:template>
</xsl:stylesheet>