<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def urlPrefix="/"+PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category),"/")+varDomainName;
  def columns=tableDefine.columns;
  urlPrefix=urlPrefix.replace("//","/");
  def pkColumn=tableDefine.getPkColumn();

  def containerId='view_'+varDomainName.toLowerCase();
  def requireInfo=requireUtil.getRequireInfo(tableModel,'viewList');
  if(requireInfo.hasModule()){
	 def dataMap=["requireInfo":requireInfo,"containerId":containerId];
	if(extendConf['requirejs']=='true'){
	 println snippetTemplateUtil.getTemplateByMap(dataMap,'requireJsScript');
	}else{
	  println snippetTemplateUtil.getTemplateByMap(dataMap,'elementInit');
	}
  }

%>#set(\$layout='/WEB-INF/vm/layout/adminLayout.vm')

<div class="modal-body" id="${containerId}">
	<form class="form-horizontal"  id="form1">
	<% columns.each{
		  def column=it;
		  if(tableModel.isNotInList('viewList',column.columnName)){
			return ;
		  }
	%>
		 <div class="control-group">
			<label class="control-label" for="${it.dataName}">${column.cnname}</label>
			<div class="controls">
			<%
		        if("Select".equalsIgnoreCase(it.jspTag)){
				         println dictUtil.getDictTemplate(column,"dict-viewPage-disp");
	        		}else if("radio".equalsIgnoreCase(column.jspTag)){
					println dictUtil.getDictTemplate(column,"dict-radio-readonly");
				}else if("checkbox".equalsIgnoreCase(column.jspTag)){
					 println dictUtil.getDictTemplate(column,"dict-checkbox-readonly");
				}else if("textarea".equalsIgnoreCase(column.jspTag)){
                 %>
                 <textarea  name="${column.dataName}" id="${column.dataName}" placeholder="请输入${column.cnname}" readonly  rows="5">\$!{${varDomainName}.${it.dataName}}</textarea>

                  <%}
                 else if("editor".equalsIgnoreCase(it.jspTag)){
					%>
					<textarea name="${it.dataName}" id="${it.dataName}" readonly class="j_editor"  style="width:95%;min-height:250px;max-width:800px;">\$!{${varDomainName}.${it.dataName}}</textarea>
					<%
	        		}else if("Date".equalsIgnoreCase(it.jspTag)){
					%>
						<input type="text"  name="${it.dataName}" id="${it.dataName}" value="\$!dateFormatUtils.format(\$!${varDomainName}.${it.dataName},"yyyy-MM-dd")" readonly/>
					<%
					}else if("DateTime".equalsIgnoreCase(it.jspTag)){
					%>
						<input type="text"  name="${it.dataName}" id="${it.dataName}" value="\$!dateFormatUtils.format(\$!${varDomainName}.${it.dataName})" readonly/>
					<%
	        		}
	        		else {%>
					<input type="text"  name="${it.dataName}" id="${it.dataName}" value="\$!{${varDomainName}.${it.dataName}}" readonly/>
				<%
				}
				%>
			</div>
		</div>
		<%
		}
		%>

	</form>
</div>
<div class="modal-footer">
	<a href="javascript:;" class="btn btn-sm" onclick="backToManage();">返回</a>
</div>


<script language="javascript">


function backToManage(){
	var url='${urlPrefix}/manage.action';
	gUtils.fMakeFullLink(url);
    window.location=url;
}

</script>