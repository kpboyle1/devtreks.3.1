﻿<?xml version="1.0" encoding="UTF-8" ?>
<!-- Author: www.devtreks.org, 2013, November -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:DisplayDevPacks="urn:displaydevpacks">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" />
	<!-- pass in params -->
	<!--array holding references to constants, locals, lists ...-->
	<xsl:param name="linkedListsArray" />
	<!-- calcs -->
	<xsl:param name="saveMethod" />
	<!-- default linked view -->
	<xsl:param name="defaultLinkedViewId" />
	<!-- the last step is used to display different parts of the calculator-->
	<xsl:param name="lastStepNumber" />
	<!-- what action is being taken by the server -->
	<xsl:param name="serverActionType" />
	<!-- what other action is being taken by the server -->
	<xsl:param name="serverSubActionType" />
	<!-- is the member viewing this uri the owner? -->
	<xsl:param name="isURIOwningClub" />
	<!-- which node to start with? -->
	<xsl:param name="nodeName" />
	<!-- which view to use? -->
	<xsl:param name="viewEditType" />
	<!-- is this a coordinator? -->
	<xsl:param name="memberRole" />
	<!-- what is the current uri? -->
	<xsl:param name="selectedFileURIPattern" />
	<!-- the addin being used -->
	<xsl:param name="calcDocURI" />
	<!-- the node being calculated (custom docs' nodename can be a devpack, while this might be budgetgroup) -->
	<xsl:param name="docToCalcNodeName" />
	<!-- standard params used with calcs and custom docs -->
	<xsl:param name="calcParams" />
	<!-- what is the name of the node to be selected? -->
	<xsl:param name="selectionsNodeNeededName" />
	<!-- which network is this doc from? -->
	<xsl:param name="networkId" />
	<!-- what is the start row? -->
	<xsl:param name="startRow" />
	<!-- what is the end row? -->
	<xsl:param name="endRow" />
	<!-- what are the pagination properties ? -->
	<xsl:param name="pageParams" />
	<!-- what is the club's email? -->
	<xsl:param name="clubEmail" />
	<!-- what is the current serviceid? -->
	<xsl:param name="contenturipattern" />
	<!-- path to resources -->
	<xsl:param name="fullFilePath" />
	<xsl:variable name="linkedviewid"><xsl:value-of select="DisplayDevPacks:GetURIPatternPart($calcDocURI,'id')" /></xsl:variable>
	<!-- init html -->
	<xsl:template match="@*|/|node()" />
	<xsl:template match="/">
		<div class="box">
			<xsl:if test="($serverActionType = 'linkedviews')">
				<div id="stepsmenu">
					<xsl:value-of select="DisplayDevPacks:WriteMenuSteps('3')"/>
				</div>
			</xsl:if>
			<xsl:apply-templates select="root" />
			<div>
				<br />
				<strong>Current view of document</strong>
				<br />
			</div>
		</div>
	</xsl:template>
	<xsl:template match="root">
    <div id="divstepzero">
      <xsl:choose>
        <xsl:when test="($docToCalcNodeName = 'inputgroup' 
							or $docToCalcNodeName = 'input' 
							or $docToCalcNodeName = 'inputseries'
							or contains($docToCalcNodeName, 'devpack') 
							or contains($docToCalcNodeName, 'linkedview'))">
				</xsl:when>
				<xsl:otherwise>
					<h3>This input analyzer does not appear appropriate for the document being analyzed. Are you 
					sure this is the right analyzer?</h3>
				</xsl:otherwise>
			</xsl:choose>
      <h4 class="ui-bar-b"><strong>Life Cycle Cost Calculation View</strong></h4>
      <h4 class="ui-bar-b">
					<strong>
						<xsl:value-of select="linkedview[@Id=$linkedviewid]/@CalculatorName" />
					</strong>
			</h4>
			<p>
					<strong>Introduction</strong>
					<br />
					This tool generates a variety of basic life cycle cost stock statistics for DevTreks inputs.
			</p>
			<p>
				<strong>Calculation View Description</strong>
				<br />
				<xsl:value-of select="linkedview[@Id=$linkedviewid]/@CalculatorDescription" />
			</p>
			<p>
				<strong>Version: </strong>
				<xsl:value-of select="linkedview[@Id=$linkedviewid]/@Version"/>
			</p>
			<p>
				<a id="aFeedback" name="Feedback">
					<xsl:attribute name="href">mailto:<xsl:value-of select="$clubEmail" />?subject=<xsl:value-of select="$selectedFileURIPattern" /></xsl:attribute>
					Feedback About <xsl:value-of select="$selectedFileURIPattern" />
				</a>
			</p>
		</div>
		<xsl:apply-templates select="linkedview" />
	</xsl:template>
	<xsl:template match="linkedview">
		<xsl:if test="(@Id = $linkedviewid) or (@Id = 1)">
			<xsl:variable name="searchurl"><xsl:value-of select="DisplayDevPacks:GetURIPattern(@CalculatorName,@Id,$networkId,local-name(),'')" /></xsl:variable>
			<div id="divstepone">
        <h4 class="ui-bar-b"><strong>Step 1 of 3. Make Selections</strong></h4>
		    <xsl:variable name="calcParams1">'&amp;step=steptwo<xsl:value-of select="$calcParams" />'</xsl:variable>
			  <xsl:if test="($viewEditType = 'full')">
				  <xsl:value-of select="DisplayDevPacks:WriteGetConstantsButtons($selectedFileURIPattern, $contenturipattern, $calcParams1)"/>
			  </xsl:if>
			  <xsl:if test="($lastStepNumber = 'steptwo')">
          <h4 class="ui-bar-b"><strong>Success. Please review the selections below.</strong></h4>
			  </xsl:if>
        <br />
			  <div>
          <label for="CalculatorName" class="ui-hidden-accessible"></label>
					<input id="CalculatorName" type="text" data-mini="true">
            <xsl:if test="($viewEditType = 'full')">
							<xsl:attribute name="name"><xsl:value-of select="$searchurl" />;CalculatorName;string;75</xsl:attribute>
            </xsl:if>
						<xsl:attribute name="value"><xsl:value-of select="@CalculatorName" /></xsl:attribute>
					</input>
			  </div>
        <div>
				  <label for="lblFileToAnalysisExtensionType" >Base Calculations To Analyze Type:</label>
				  <select id="lblFileToAnalysisExtensionType" data-mini="true">
            <xsl:if test="($viewEditType = 'full')">
						  <xsl:attribute name="name"><xsl:value-of select="$searchurl" />;FilesToAnalyzeExtensionType;string;25</xsl:attribute>
            </xsl:if>
            <option>
							<xsl:attribute name="value">none</xsl:attribute>
							<xsl:if test="(@FilesToAnalyzeExtensionType = 'none' or @FilesToAnalyzeExtensionType = '')">
								<xsl:attribute name="selected" />
							</xsl:if>Needs Selection
						</option>
						<option>
              <xsl:attribute name="value">input</xsl:attribute>
							<xsl:if test="(@FilesToAnalyzeExtensionType = 'input')">
								<xsl:attribute name="selected" />
							</xsl:if>Base Inputs
						</option>
				  </select>
			  </div>
        <div>
				  <label for="lblAnalyzerType" >Analysis Type:</label>
				  <select id="lblAnalyzerType" data-mini="true">
            <xsl:if test="($viewEditType = 'full')">
						  <xsl:attribute name="name"><xsl:value-of select="$searchurl" />;AnalyzerType;string;25</xsl:attribute>
            </xsl:if>
            <option>
							<xsl:attribute name="value">none</xsl:attribute>
							<xsl:if test="(@AnalyzerType = 'none' or @AnalyzerType = '')">
								<xsl:attribute name="selected" />
							</xsl:if>Needs Selection
						</option>
						<option>
							<xsl:attribute name="value">lcatotal1</xsl:attribute>
							<xsl:if test="(@AnalyzerType = 'lcatotal1')">
								<xsl:attribute name="selected" />
							</xsl:if>Totals
						</option>
						<option>
							<xsl:attribute name="value">lcastat1</xsl:attribute>
							<xsl:if test="(@AnalyzerType = 'lcastat1')">
								<xsl:attribute name="selected" />
							</xsl:if>Statistics 1
						</option>
            <option>
							<xsl:attribute name="value">lcachangeyr</xsl:attribute>
							<xsl:if test="(@AnalyzerType = 'lcachangeyr')">
								<xsl:attribute name="selected" />
							</xsl:if>Change By Year
						</option>
            <option>
							<xsl:attribute name="value">lcachangeid</xsl:attribute>
							<xsl:if test="(@AnalyzerType = 'lcachangeid')">
								<xsl:attribute name="selected" />
							</xsl:if>Change By Id
						</option>
            <option>
							<xsl:attribute name="value">lcachangealt</xsl:attribute>
							<xsl:if test="(@AnalyzerType = 'lcachangealt')">
								<xsl:attribute name="selected" />
							</xsl:if>Change By Alternative
						</option>
            <option>
							<xsl:attribute name="value">lcaprogress1</xsl:attribute>
							<xsl:if test="(@AnalyzerType = 'lcaprogress1')">
								<xsl:attribute name="selected" />
							</xsl:if>Progress 1
						</option>
				  </select>
			  </div>
			  <div>
				  <label for="lblDescription">Description</label>
				  <textarea id="lblDescription" data-mini="true">
            <xsl:if test="($viewEditType = 'full')">
						  <xsl:attribute name="name"><xsl:value-of select="$searchurl" />;CalculatorDescription;string;255</xsl:attribute>
            </xsl:if>
					  <xsl:value-of select="@CalculatorDescription" />
				  </textarea>
			  </div>
        <div >
				  <label for="lblMediaURL">Media URL</label>
				  <textarea class="Text75H100PCW" id="lblMediaURL" data-mini="true">
            <xsl:if test="($viewEditType = 'full')">
						  <xsl:attribute name="name"><xsl:value-of select="$searchurl" />;MediaURL;string;500</xsl:attribute>
            </xsl:if>
					  <xsl:value-of select="@MediaURL" />
				  </textarea>
			  </div>
		  </div>
      <div id="divsteptwo">
			  <h4 class="ui-bar-b"><strong>Step 2 of 3. Analyze</strong></h4>
			  <xsl:variable name="calcParams3">'&amp;step=stepthree<xsl:value-of select="$calcParams"/>'</xsl:variable>
        <xsl:if test="($viewEditType = 'full')">
				  <xsl:value-of select="DisplayDevPacks:WriteCalculateButtons($selectedFileURIPattern, $contenturipattern, $calcParams3)"/>
			  </xsl:if>
			  <xsl:if test="($lastStepNumber = 'stepthree')">
            <h4 class="ui-bar-b"><strong>Success. Please review the calculations below.</strong></h4>
			  </xsl:if>
        <xsl:if test="(($docToCalcNodeName != 'inputseries') or contains($docToCalcNodeName, 'devpack') or contains($docToCalcNodeName, 'linkedview'))">
          <div data-role="collapsible"  data-theme="b" data-content-theme="d">
          <h4>Relations</h4>
	        <xsl:value-of select="DisplayDevPacks:WriteStandardCalculatorParams1($searchurl, $viewEditType,
                @UseSameCalculator, @Overwrite)"/>
          </div>
        </xsl:if>
        <xsl:value-of select="DisplayDevPacks:WriteStandardCalculatorParams2($searchurl, $viewEditType,
          @WhatIfTagName, '')"/>
        <div>
				  <label for="lblRelatedCalculatorType" >Base Resource (Input) Calculations To Analyze Type:</label>
				  <select id="lblRelatedCalculatorType" data-mini="true">
            <xsl:if test="($viewEditType = 'full')">
						 <xsl:attribute name="name"><xsl:value-of select="$searchurl" />;RelatedCalculatorType;string;25</xsl:attribute>
            </xsl:if>
            <option>
							<xsl:attribute name="value">none</xsl:attribute>
							<xsl:if test="(@RelatedCalculatorType = 'none' or @RelatedCalculatorType = '')">
								<xsl:attribute name="selected" />
							</xsl:if>Needs Selection
						</option>
						<option>
							<xsl:attribute name="value">buildcost1</xsl:attribute>
							<xsl:if test="(@RelatedCalculatorType = 'buildcost1')">
								<xsl:attribute name="selected" />
							</xsl:if>Life Cycle Basic Costs
						</option>
				  </select>
			  </div>
        <xsl:if test="(@AnalyzerType = 'lcastat1' or @AnalyzerType = 'lcaprogress1')">
          <xsl:value-of select="DisplayDevPacks:WriteStandardAnalysisParams1($searchurl, $viewEditType,
            $docToCalcNodeName, @Option1, @Option2, @Option4)"/>
        </xsl:if>
        <xsl:if test="(@AnalyzerType = 'lcachangeyr' or @AnalyzerType = 'lcachangeid' or @AnalyzerType = 'lcachangealt')">
          <xsl:value-of select="DisplayDevPacks:WriteStandardComparisons($searchurl, $viewEditType,
            $docToCalcNodeName, @Option1)"/>
        </xsl:if>
      </div>
      <div id="divstepthree">
			  <xsl:variable name="filexttype"><xsl:value-of select="DisplayDevPacks:GetSubString($selectedFileURIPattern,'/','5')" /></xsl:variable>
			  <xsl:if test="($lastStepNumber != 'stepfour')">
          <h4 class="ui-bar-b"><strong>Step 3 of 3. Save</strong></h4>
				  <xsl:if test="$filexttype = 'temp' or contains($docToCalcNodeName, 'linkedview')">
            <p>
							  <strong>Temporary Calculations.</strong> Calculations are temporarily saved when temporary calculations are run.
					  </p>
				  </xsl:if>
				  <xsl:if test="($filexttype != 'temp') and (contains($docToCalcNodeName, 'linkedview') = false)">
					  <xsl:variable name="calcParams4a">'&amp;step=stepfour&amp;savemethod=analyses<xsl:value-of select="$calcParams"/>'</xsl:variable>
            <p>
							  <strong>Method 1.</strong> Do you wish to save step 2's calculations? These calculations are viewed by opening this particular calculator addin.
					  </p>
					  <xsl:if test="($viewEditType = 'full')">
						  <xsl:value-of select="DisplayDevPacks:MakeDevTreksButton('savecalculation', 'SubmitButton1Enabled150', 'Save Calcs', $contenturipattern, $selectedFileURIPattern, 'prepaddin', 'linkedviews', 'runaddin', 'none', $calcParams4a)" />
					  </xsl:if>
				  </xsl:if>
			  </xsl:if>
			  <xsl:if test="($lastStepNumber = 'stepfour')
				  or ($lastStepNumber = 'stepthree' and $filexttype = 'temp')">
						  <h3>
								<xsl:if test="($saveMethod != 'saveastext'
									or $filexttype = 'temp')">
									Your analysis has been saved. The analysis can be viewed whenever
									this analyzer addin is opened.
								</xsl:if>
								<xsl:if test="($saveMethod = 'saveastext')">
									The analysis has been saved. The text document can be downloaded by clicking on the 
									Add To Package link and downloading a package.
								</xsl:if>
							</h3>
			  </xsl:if>
		  </div>
      <div id="divsteplast">
			  <h4 class="ui-bar-b"><strong>Instructions </strong></h4>
        <div data-role="collapsible"  data-theme="b" data-content-theme="d">
			  <h4>Step 1</h4>
			  <ul data-role="listview">
				  <li><strong>Step 1. Base Calculations To Analyze:</strong> Choose the one option offered in this version of the analyzer.</li>
					<li><strong>Step 1. Analysis Type:</strong> Totals add together the resource stocks being analyzed. Mean and Standard deviation is not available yet.</li>
			  </ul>
			  </div>
        <div data-role="collapsible"  data-theme="b" data-content-theme="d">
			  <h4>Step 2</h4>
			  <ul data-role="listview">
				  <li><strong>Step 2. Use Same Calculator Pack In Descendants?:</strong> True to insert or update this same calculator in children.</li>
				  <li><strong>Step 2. What If Tag Name:</strong> Instructional videos explaining the use of what-if scenario calculations should be viewed before changing or using this parameter.</li>
          <li><strong>Step 2. Base Resource Calculations To Analyze Type:</strong> The calculator chosen should actually be used, and used fairly frequently, in the underlying data being analyzed.</li>
					<li><strong>Step 2. Related Calculators Type:</strong> Name of the "Related Calculator Type" found in descendants. Runs calculations using the data found in those descendant linked views. 
            This property takes precedence over the "Base Resoure Calculations to Analyze Type" property. </li>
          <li><strong>Step 2. Alternative:</strong> Used for comparisons.</li>
          <li><strong>Step 2. Target Type:</strong> Used for progress analysis and to set benchmarks and actuals.</li>
			  </ul>
        </div>
        <div data-role="collapsible"  data-theme="b" data-content-theme="d">
			  <h4>Step 3</h4>
          <ul data-role="listview">
				    <li><strong>Step 3. Save Using:</strong> The Save command saves xml data the Save Text command saves csv data.</li>
			    </ul>
        </div>
        <br /><br />
        <h4>Reminder: The 'Resource Stock Totals' analyzer requires running the underlying LCA calculator after inserting, deleting, 
								or updating, this linked view (that keeps the LCA calculator's linked views synchronized with these linkedviews).
        </h4>
		  </div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
