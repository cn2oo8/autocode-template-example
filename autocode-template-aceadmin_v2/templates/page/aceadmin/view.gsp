#set(\$layout='/WEB-INF/vm/layout/adminLayout.vm')
<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def urlPrefix="/"+PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category),"/")+varDomainName;
  def columns=tableDefine.columns;
  urlPrefix=urlPrefix.replace("//","/");

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
%>

<div class="modal-body " id="${containerId}">
	<form class="form-horizontal"  id="form1" role="form">
	<% columns.each{
		  def column=it;
		  if(tableModel.isNotInList('viewList',column.columnName)){
			return ;
		  }
	%>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="${column.dataName}">${column.cnname}</label>
			<div class="col-sm-8 controls">
			<%
		        	if("Select".equalsIgnoreCase(it.jspTag))
		        	{
					println dictUtil.getDictTemplate(column,"dict-viewPage-disp");
	        		}else if("radio".equalsIgnoreCase(column.jspTag)){
					println dictUtil.getDictTemplate(column,"dict-radio-readonly");
				}else if("checkbox".equalsIgnoreCase(column.jspTag)){
					 println dictUtil.getDictTemplate(column,"dict-checkbox-readonly");
				}else if("textarea".equalsIgnoreCase(column.jspTag)){
				 	 %>
				 	 <textarea  class="form-control"  name="${column.dataName}" id="${column.dataName}" placeholder="请输入${column.cnname}"
				 	 readonly  rows="5">\$!{${varDomainName}.${it.dataName}}</textarea>
				   <%}else if("editor".equalsIgnoreCase(it.jspTag)){
					%>
					<textarea class="form-control j_editor"  name="${it.dataName}" id="${it.dataName}" readonly
					 style="min-height:250px;">\$!{${varDomainName}.${it.dataName}}</textarea>
					<%
	        		}else if("Date".equalsIgnoreCase(it.jspTag)){
					%>
						<input type="text" class="form-control" name="${it.dataName}" id="${it.dataName}" value="\$!dateFormatUtils.format(\$!${varDomainName}.${it.dataName},"yyyy-MM-dd")" readonly/>
					<%
					}else if("DateTime".equalsIgnoreCase(it.jspTag)){
						%>
					<input type="text"  class="form-control" name="${it.dataName}" id="${it.dataName}" value="\$!dateFormatUtils.format(\$!${varDomainName}.${it.dataName})" readonly/>
						<%
	        			}
	        		else {%>
							<input type="text" class="form-control" name="${it.dataName}" id="${it.dataName}" value="\$!{${varDomainName}.${it.dataName}}" readonly/>
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
	url=gUtils.fMakeFullLink(url);
    window.location=url;
}

</script>