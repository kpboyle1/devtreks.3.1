﻿using DevTreks.Models;
using DevTreks.Data;
using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Localization;
using DataHelpers = DevTreks.Data.Helpers.GeneralHelpers;
using Localizations = DevTreks.Resources;

namespace DevTreks.Helpers
{
    /// <summary>
    ///Purpose:		Helper functions for views
    ///Author:		www.devtreks.org
    ///Date:		2016, March
    ///References:	www.devtreks.org/helptreks/linkedviews/help/linkedview/HelpFile/148
    /// </summary>
    public static class AppHelper
    {
        
        public static void SetErrorMessage(Exception x, DevTreks.Data.ContentURI uri)
        {
            //move this to error component and tie in with help file system 
            //dynamic help, dynamic messaging
            string sExceptionMessage = x.ToString();
            string sErrorMessage = string.Empty;
            if (uri.URIDataManager != null)
            {
                //the error was generated by the search page 
                if (uri.URIService == null)
                    uri.URIService = new AccountToService();
                if (uri.URIMember == null)
                    uri.URIMember = new AccountToMember();
                if (uri.URIMember.ClubInUse == null)
                    uri.URIMember.ClubInUse = new Account();
                sErrorMessage += (x.InnerException == null) ? string.Empty : x.InnerException.ToString();
                sErrorMessage = string.Concat(sExceptionMessage, "</ br>", uri.ErrorMessage);
                string[] arrErrorMessage = {uri.URIDataManager.ServerActionType.ToString(), 
                    uri.URIDataManager.AppType.ToString(), 
                    uri.URIDataManager.SubAppType.ToString(),
                    uri.URINodeName,
                    uri.URIId.ToString(),
                    uri.URIService.PKId.ToString(),
                    uri.URIMember.ClubInUse.ToString(), 
                    sErrorMessage};
                uri.ErrorMessage = PublishError(uri, x.InnerException,
                    DataHelpers.MakeStringWithDelimiter(arrErrorMessage,
                    DataHelpers.STRING_DELIMITER));
            }
            else
            {
                //xml document or file upload error
                uri.ErrorMessage = DevTreks.Exceptions.DevTreksErrors.MakeStandardErrorMsg(string.Empty, "APPHELPER_WHOKNOWS");
            }
        }
        public static void PublishErrorMessage(DevTreks.Data.ContentURI uri)
        {
            string sErrorMessage = string.Empty;

            if (!string.IsNullOrEmpty(uri.ErrorMessage))
            {
                if (uri.URIDataManager == null)
                    uri.URIDataManager = new DevTreks.Data.ContentURI.DataManager();
                //the error was generated by the search page 
                if (uri.URIService == null)
                    uri.URIService = new AccountToService();
                if (uri.URIMember == null)
                    uri.URIMember = new AccountToMember();
                if (uri.URIMember.ClubInUse == null)
                    uri.URIMember.ClubInUse = new Account();
                string[] arrErrorMessage = {uri.URIDataManager.ServerActionType.ToString(), 
                    uri.URIDataManager.AppType.ToString(), 
                    uri.URIDataManager.SubAppType.ToString(),
                    uri.URINodeName,
                    uri.URIId.ToString(),
                    uri.URIService.PKId.ToString(),
                    uri.URIMember.ClubInUse.ToString(), 
                    uri.ErrorMessage};
                //160 changed from getneworkpath to this
                string sErrorPath = string.Concat(DevTreks.Data.Helpers.AppSettings.GetResourceRootPath(uri, false), 
                    DevTreks.Exceptions.DevTreksErrors.ERRORFOLDERNAME, DataHelpers.FILE_PATH_DELIMITER);
                uri.ErrorMessage = DevTreks.Exceptions.DevTreksErrors.Publish(DataHelpers.MakeStringWithDelimiter(arrErrorMessage,
                    DataHelpers.STRING_DELIMITER), sErrorPath);
            }
        }
        public static string GetMessage(string message)
        {
            string sMessage = string.Empty;
            if (!string.IsNullOrEmpty(message))
            {
                sMessage = string.Format("<div class=\"notify-error\">{0}</div>", message);
            }
            return sMessage;
        }
        public static string GetErrorMessage(string errorName)
        {
            string sErrorMessage = string.Empty;
            if (!string.IsNullOrEmpty(errorName))
            {
                sErrorMessage = DevTreks.Exceptions.DevTreksErrors.GetMessage(errorName);
            }
            return sErrorMessage;
        }
        public static string PublishError(ContentURI uri,
            Exception error, string errorName)
        {
            //version 160 changed getnetworkpath
            string sErrorValue = DevTreks.Exceptions.DevTreksErrors.Publish(error, errorName,
               string.Concat(DevTreks.Data.Helpers.AppSettings.GetResourceRootPath(uri, false), 
               DevTreks.Exceptions.DevTreksErrors.ERRORFOLDERNAME, DataHelpers.FILE_PATH_DELIMITER));
            return sErrorValue;
        }
        
        /// <summary>
        /// This method retrieves localized resource strings.
        /// </summary>
        /// <param name="resourceName"></param>
        /// <returns>localized string</returns>
        public static string GetResource(string resourceName)
        {
            //localization is initialized in Startup.cs
            string sResourceValue 
                = Localizations.DevTreksResources.GetDevTreksString(resourceName);
            return sResourceValue;
        }
        public static bool CanDeleteNode(string currentNode, string okNode,
            DataHelpers.SERVER_ACTION_TYPES serveraction, AccountToMember member)
        {
            bool bCanDelete = false;
            if (member != null)
            {
                if (member.AccountId == 0)
                {
                    //anonymous user can edit, but not delete nodes
                    //only owner can delete content
                    return false;
                }
            }
            else
            {
                return false;
            }
            bCanDelete = (currentNode == okNode) ? false : true;
            if (serveraction != DataHelpers.SERVER_ACTION_TYPES.edit)
            {
                bCanDelete = false;
            }
            return bCanDelete;
        }
        public static string GetAdminFolderPath(string adminFilePath,
            DataHelpers.APPLICATION_TYPES adminAppType,
            DataHelpers.APPLICATION_TYPES neededAdminAppType)
        {
            string sFolderPath = string.Empty;
            //adminFilePath: c:\dtfiledata\club_148\agreements\serviceaccount\filename.xml
            //need the c:\dtfiledata\club_148\ root
            int iEndIndex = adminFilePath.IndexOf(adminAppType.ToString());
            string sRootPath = adminFilePath.Substring(0, iEndIndex);
            if (neededAdminAppType == DataHelpers.APPLICATION_TYPES.networks)
            {
                sFolderPath = string.Concat(sRootPath, neededAdminAppType.ToString(),
                    DataHelpers.FILE_PATH_DELIMITER,
                    DevTreks.Data.AppHelpers.Networks.NETWORK_TYPES.networkaccountgroup.ToString(),
                    DataHelpers.FILE_PATH_DELIMITER);
            }
            //else if: in this version, only networks use this method
            return sFolderPath;
        }
        
    }
}