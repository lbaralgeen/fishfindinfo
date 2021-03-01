using System;
using System.Collections.Generic;
using System.Xml;
using System.Text;
using System.IO;

#pragma warning disable 1591

namespace FishTracker
{
    public static class XmlExtension
    {
        // getting xml node attribute without exceptions
        public static string AtName(this XmlNode value)
        {
            return GetAttr(value, "Name");
        }
        public static string AtTable(this XmlNode value)
        {
            return GetAttr(value, "Table");
        }
        public static string AtValue(this XmlNode value)
        {
            return GetAttr(value, "Value");
        }
        public static string AtInfo(this XmlNode value)
        {
            return GetAttr(value, "Info");
        }
        public static string AtId(this XmlNode value)
        {
            return GetAttr(value, "Id");
        }
        public static string GetXmlAsString(this XmlDocument xmlDoc)
        {
            Encoding utf8noBOM = new UTF8Encoding(false);
            var prettyXmlString = new StringBuilder();
            var xmlSettings = new XmlWriterSettings()
            {
                Indent = true,
                IndentChars = " ",
                NewLineChars = "\r\n",
                Encoding = utf8noBOM,
                NewLineHandling = NewLineHandling.Replace
             };
            using (XmlWriter writer = XmlWriter.Create(prettyXmlString, xmlSettings))
            {
                xmlDoc.Save(writer);
            }
            string doc = prettyXmlString.ToString();
            return doc.Replace("utf-16", "utf-8");
        }
        public static string GetXmlAsString2(this XmlNode value)
        {
            using (System.IO.StringWriter sw = new System.IO.StringWriter())
            {
                using (XmlTextWriter tx = new XmlTextWriter(sw))
                {
                    value.WriteTo(tx);
                    return sw.ToString();
                }
            }
        }
        public static string GetAttr(this XmlNode value, string attributeToFind)
        {
            if( null == value || String.IsNullOrEmpty(attributeToFind) )
            {
                return null;
            }
            attributeToFind = attributeToFind.Trim();
            string returnValue = string.Empty;
            XmlElement ele = value as XmlElement;

            if( null == ele || String.IsNullOrEmpty(attributeToFind) )
            {
                return null;
            }
            if (ele.HasAttribute(attributeToFind))
            {
                return ele.GetAttribute(attributeToFind);
            }
            return returnValue;
        }
        // exctract pointer to tree node if was saved in xml node
        public static bool SetAttr(this XmlNode node, string nameAttr, string value)
        {
            if(node == null || String.IsNullOrEmpty(nameAttr))
            {
                return false;
            }
            nameAttr = nameAttr.Trim();

            if(String.IsNullOrEmpty(nameAttr))
            {
                return false;
            }
            if ( value == null )
            {
                node.RemoveAttr(nameAttr);

                return true;
            }
            try
            {
                XmlElement ele = node as XmlElement;

                if (ele.HasAttribute(nameAttr))
                {
                    ele.SetAttribute(nameAttr, value);
                }
                else
                {
                    XmlAttribute attr = node.OwnerDocument.CreateAttribute(nameAttr);
                    attr.Value = value;
                    node.Attributes.SetNamedItem(attr);
                }
                return true;
            }
            catch (Exception )
            {
//                Tlog.Error(ex.Message);
            }
            return false;
        }
        public static bool SetAttr(this XmlNode parentXmlNode, string nameAttr, int value)
        {
            return SetAttr(parentXmlNode, nameAttr, value.ToString());
        }
        public static bool SetAttr(this XmlNode parentXmlNode, string nameAttr, bool value)
        {
            return SetAttr(parentXmlNode, nameAttr, (value ? "0" : "1"));
        }
        public static bool SetAttr(this XmlNode parentXmlNode, string nameAttr, int? value)
        {
            return SetAttr(parentXmlNode, nameAttr, (value == null ) ? string.Empty : value.ToString() );
        }
        public static bool SetAttr(this XmlNode parentXmlNode, string nameAttr, Guid value)
        {
            if (value == null)
            {
                return SetAttr(parentXmlNode, nameAttr, string.Empty);
            }
            return SetAttr(parentXmlNode, nameAttr, value.ToString());
        }
        public static bool RemoveChildren(this XmlNode parentXmlNode)
        {
            if( parentXmlNode == null )
            {
                return false;
            }
            while(parentXmlNode.HasChildNodes)
            {
                XmlNode entry = parentXmlNode.ChildNodes[0];
                parentXmlNode.RemoveChild(entry);
            }
            return !parentXmlNode.HasChildNodes;
        }
        public static bool RemoveAttr(this XmlNode parentXmlNode, string[] attrs)
        {
            if(parentXmlNode == null || attrs == null || attrs.Length == 0)
            {
                return false;
            }
            foreach (string nameAttr in attrs)
            {
                parentXmlNode.RemoveAttr(nameAttr);
            }
            return true;
        }
        public static bool ReplaceNode(this XmlNode targetNode, XmlDocument targetDoc, XmlNode sourceNode)
        {
            if (targetNode == null || sourceNode == null || targetDoc == null )
            {
                return false;
            }
            XmlNode parentNode = targetNode.ParentNode;
            parentNode.RemoveChild(targetNode);
            parentNode.AppendChild(targetDoc.ImportNode(sourceNode, true));
            return true;
        }
        public static bool ReplaceNode(this XmlDocument targetDoc, XmlNode sourceNode, string xPath)
        {
            if ( String.IsNullOrEmpty(xPath) || sourceNode == null || targetDoc == null)
            {
                return false;
            }
            XmlNode targetNode = targetDoc.DocumentElement.SelectSingleNode("//" + xPath);
            XmlNode srcNode = sourceNode.SelectSingleNode("//" + xPath);
            return targetNode.ReplaceNode(targetDoc, srcNode);
        }
        public static bool RemoveAttr(this XmlNode parentXmlNode, string nameAttr)
        {
            if(parentXmlNode == null || String.IsNullOrEmpty(nameAttr))
            {
                return false;
            }
            nameAttr = nameAttr.Trim();

            if(String.IsNullOrEmpty(nameAttr))
            {
                return false;
            }
            try
            {
                XmlElement ele = parentXmlNode as XmlElement;

                if (ele.HasAttribute(nameAttr))
                {
                    ele.RemoveAttribute(nameAttr);
                }
                return true;
            }
            catch (Exception )
            {
//                Tlog.Error(ex.Message);
            }
            return false;
        }
        // copy all attributes from one node to another
        public static XmlNode CopyAttr(this XmlNode nodeTarget, XmlNode nodeSource)
        {
            if( nodeTarget == null )
            {
                return null;
            }
            if (nodeSource == null)
            {
                return nodeTarget;
            }
            try
            {
                foreach (XmlAttribute iter in nodeSource.Attributes)
                {
                    nodeTarget.SetAttr(iter.Name, iter.Value);
                }
                return nodeTarget;
            }
            catch (Exception )
            {
 //               Tlog.Error(ex.Message);
            }
            return null;
        }
        public static XmlNode AddNode(this XmlNode parentXmlNode, string nameNode)
        {
            if (null == parentXmlNode || String.IsNullOrEmpty(nameNode))
            {
                return null;
            }
            nameNode = nameNode.Trim();

            if(String.IsNullOrEmpty(nameNode))
            {
                return null;
            }
            try
            {
                XmlNode result = parentXmlNode.OwnerDocument.CreateNode(XmlNodeType.Element, nameNode, "");
                parentXmlNode.AppendChild(result);
                return result;
            }
            catch (Exception )
            {
 //               Tlog.ErrorFormat("[{0}] name node: {1} value: {2}", ex.Message, parentXmlNode.Name, nameNode);
            }
            return null;
        }
        public static string GetInnerText(this XmlNode dataNode)
        {
            if (null == dataNode)
            {
                return null;
            }
            if (dataNode.ChildNodes != null && dataNode.ChildNodes.Count > 0)
            {
                XmlNode inner = dataNode.ChildNodes.Item(0);

                if (inner.NodeType == XmlNodeType.Text)
                {
                    return inner.Value;
                }
            }
            return string.Empty;
        }
        public static XmlNodeList SelectChildren(this XmlNode parentXmlNode, string nameNode)
        {
            if (!parentXmlNode.HasChildNodes)
            {
                return null;
            }
            return parentXmlNode.SelectNodes(parentXmlNode.Prefix + nameNode);
        }
        public static XmlNode SelectFirstChild(this XmlNode parentXmlNode, string nameNode)
        {
            if (!parentXmlNode.HasChildNodes)
            {
                return null;
            }
            if (String.IsNullOrEmpty(nameNode))
            {
                XmlNodeList lst = parentXmlNode.ChildNodes;

                if (lst == null || lst.Count == 0)
                {
                    return null;
                }
                return lst.Item(0);
            }
            XmlNodeList nodes = parentXmlNode.SelectNodes(parentXmlNode.Prefix + nameNode);

            if (nodes.Count == 0)
            {
                return null;
            }
            return nodes[0];
        }
        public static XmlNode RecursiveSearch(this XmlNode currentNode, string nameNode, string attrName, string attrVal)
        {
            XmlNodeList nodes = currentNode.ChildNodes;

            if (nodes == null || nodes.Count == 0)
            {
                return null;
            }
            if (String.IsNullOrEmpty(attrName))
            {
                return null;
            }
            string readValue = currentNode.GetAttr(attrName);

            if (!String.IsNullOrEmpty(readValue) && readValue == attrVal)
            {
                return currentNode;
            }
            foreach (XmlNode node in nodes)
            {
                XmlNode result = node.RecursiveSearch(nameNode, attrName, attrVal);

                if (result == null)
                {
                    continue;
                }
                else
                {
                    return result;
                }
            }
            return null;
        }
        /// <summary>
        /// find node where innertext has value
        /// </summary>
        /// <param name="currentNode"></param>
        /// <param name="nameNode"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public static XmlNode RecursiveInnerTextSearch(this XmlNode currentNode, string nameNode, string value)
        {
            XmlNodeList nodes = currentNode.ChildNodes;

            if (nodes == null || nodes.Count == 0)
            {
                return null;
            }
            if( String.IsNullOrEmpty(value) )
            {
                return null;
            }
            string readValue = currentNode.InnerText;

            if (!String.IsNullOrEmpty(readValue) && ( readValue == value || readValue.Contains(value) ))
            {
                return currentNode;
            }
            foreach (XmlNode node in nodes)
            {
                XmlNode result = node.RecursiveInnerTextSearch(nameNode, value);

                if (result == null)
                {
                    continue;
                }
                else
                {
                    return result;
                }
            }
            return null;
        }
        public static XmlNode RenameNode(this XmlNode xmlNode, string newName)
        {
            if (xmlNode.Name == newName)
            {
                return xmlNode;
            }
            XmlNode parent = xmlNode.ParentNode;
            XmlNode result = parent.AppendChild(parent.OwnerDocument.CreateNode(XmlNodeType.Element, newName, ""));
            result.InnerXml = xmlNode.InnerXml;
            parent.RemoveChild(xmlNode);
            return result;
        }
        // if nameNode node is null or empty the select all children by rule : atr name and value
        // if Value is null then all node having not empty nameAttr
        public static XmlNode SelectFirstChild(this XmlNode parentXmlNode, string nameNode, string nameAttr, string Value)
        {
            if (!parentXmlNode.HasChildNodes)
            {
                return null;
            }
            XmlNodeList nodes = null;

            if (String.IsNullOrEmpty(nameNode))
            {
                nodes = parentXmlNode.ChildNodes;
            }
            else
            {
                nodes = parentXmlNode.SelectNodes(parentXmlNode.Prefix + nameNode);
            }
            if (nodes.Count == 0)
            {
                return null;
            }
            foreach (XmlNode node in nodes)
            {
                string readValue = node.GetAttr(nameAttr);

                if (String.IsNullOrEmpty(Value))
                {
                    if (!String.IsNullOrEmpty(readValue))
                    {
                        return node;
                    }
                    continue;
                }
                if (node.GetAttr(nameAttr) == Value)
                {
                    return node;
                }
            }
            return null;
        }
        public static XmlNode SelectFirstChild(this XmlNode parentXmlNode, string nameNode, string nameAttr1, string Value1, string nameAttr2, string Value2)
        {
            if (!parentXmlNode.HasChildNodes)
            {
                return null;
            }
            XmlNodeList nodes = null;

            if (String.IsNullOrEmpty(nameNode))
            {
                nodes = parentXmlNode.ChildNodes;
            }
            else
            {
                nodes = parentXmlNode.SelectNodes(parentXmlNode.Prefix + nameNode);
            }
            if (nodes.Count == 0)
            {
                return null;
            }
            foreach (XmlNode node in nodes)
            {
                string readValue1 = node.GetAttr(nameAttr1);
                string readValue2 = node.GetAttr(nameAttr2);

                if (String.IsNullOrEmpty(Value1))
                {
                    if (!String.IsNullOrEmpty(readValue1))
                    {
                        return node;
                    }
                }
                if (String.IsNullOrEmpty(Value2) )
                {
                    if (!String.IsNullOrEmpty(readValue2))
                    {
                        return node;
                    }
                }
                if( node.GetAttr(nameAttr1) == Value1 && node.GetAttr(nameAttr2) == Value2)
                {
                    return node;
                }
            }
            return null;
        }
        /// <summary>
        /// find recursivly all nodes with name
        /// </summary>
        /// <param name="currentNode"></param>
        /// <param name="nameNode"></param>
        /// <param name="lstNode"></param>
        /// <returns></returns>
        public static bool RecursiveNodeList(this XmlNode currentNode, string nameNode, List<XmlNode> lstNode )
        {
            XmlNodeList nodes = currentNode.ChildNodes;

            if (nodes == null || String.IsNullOrEmpty(nameNode) || lstNode == null)
            {
                return false;
            }
            foreach (XmlNode node in nodes)
            {
                if (node.Name == nameNode)
                {
                    lstNode.Add(node);
                }
                node.RecursiveNodeList(nameNode, lstNode);
            }
            return true;
        }
        public static string Beautify(this XmlDocument doc)
        {
            string xmlString = null;
            using (MemoryStream ms = new MemoryStream())
            {
                XmlWriterSettings settings = new XmlWriterSettings
                {
                    Encoding = new UTF8Encoding(false),
                    Indent = true,
                    IndentChars = "  ",
                    NewLineChars = "\r\n",
                    NewLineHandling = NewLineHandling.Replace
                };
                using (XmlWriter writer = XmlWriter.Create(ms, settings))
                {
                    doc.Save(writer);
                }
                xmlString = Encoding.UTF8.GetString(ms.ToArray());
            }
            return xmlString;
        }
        public static bool SaveUTF8(this XmlDocument doc, string fileName )
        {
            if( String.IsNullOrEmpty(fileName) )
            {
                return false;
            }
            try
            {
                if (File.Exists(fileName))
                {
                    File.Delete(fileName);
                }
                if (File.Exists(fileName))
                {
                    return false;
                }
                string xmlString = null;
                using (MemoryStream ms = new MemoryStream())
                {
                    XmlWriterSettings settings = new XmlWriterSettings
                    {
                        Encoding = new UTF8Encoding(false),
                        Indent = true,
                        IndentChars = "  ",
                        NewLineChars = "\r\n",
                        NewLineHandling = NewLineHandling.Replace
                    };
                    using (XmlWriter writer = XmlWriter.Create(ms, settings))
                    {
                        doc.Save(writer);
                    }
                    xmlString = Encoding.UTF8.GetString(ms.ToArray());
                }
                if( String.IsNullOrEmpty(xmlString) )
                {
                    return false;
                }
                File.WriteAllText(fileName, doc.Beautify());

                return File.Exists(fileName);
            }
            catch(Exception)
            {
            }
            return false;
        }
    }
}
