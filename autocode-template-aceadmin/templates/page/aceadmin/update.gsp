#set(\$layout='/WEB-INF/vm/layout/adminLayout.vm')

<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def urlPrefix="/"+PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category),"/")+varDomainName;
  def columns=tableDefine.columns;
  urlPrefix=urlPrefix.replace("//","/");

  def containerId='update_'+varDomainName.toLowerCase();
  def requireInfo=requireUtil.getRequireInfo(tableModel,'updateList');
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
	<form class="form-horizontal"  id="form_update_${tableDefine.id}" role="form">
	<% columns.each{
		  def column=it;
		  if(tableModel.isNotInList('updateList',column.columnName)){
			return ;
		  }
	%>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="${column.dataName}">${column.cnname}</label>
			<div class="col-sm-7 controls">
			<%
			if("Select".equalsIgnoreCase(it.jspTag)){
			        println dictUtil.getDictTemplate(column,"dict-updatePage-disp");
			}else if("radio".equalsIgnoreCase(column.jspTag)){
			        println dictUtil.getDictTemplate(column,"dict-radio-update");
			}else if("checkbox".equalsIgnoreCase(column.jspTag)){
				 println dictUtil.getDictTemplate(column,"dict-checkbox-update");
			}else if("date".equalsIgnoreCase(column.jspTag)){
				%>
				<input type="text" class="form-control j_date_picker" name="${it.dataName}" id="${it.dataName}"
				 placeholder="请输入${column.cnname}" maxlength="${it.length}" value="\$!dateFormatUtils.format(\$!${varDomainName}.${it.dataName},"yyyy-MM-dd")" />
				<%
			}else if("datetime".equalsIgnoreCase(column.jspTag)){
				%>
				<input type="text" class="form-control j_datetime_picker" name="${it.dataName}" id="${it.dataName}"
				 placeholder="请输入${column.cnname}" maxlength="${it.length}" value="\$!dateFormatUtils.format(\$!${varDomainName}.${it.dataName})" />
				<%
			 }else if("textarea".equalsIgnoreCase(column.jspTag)){
                             %>
				   <textarea class="form-control"   name="${column.dataName}" id="${column.dataName}" placeholder="请输入${column.cnname}"  rows="5">\$!{${varDomainName}.${it.dataName}}</textarea> <%
			   }else if("editor".equalsIgnoreCase(column.jspTag)){
				%>
				<textarea class="form-control j_editor"   name="${column.dataName}" id="${column.dataName}"  placeholder="请输入${column.cnname}"  style="min-height:250px;">\$!{${varDomainName}.${it.dataName}}</textarea>
				<%
			 }
			else {%>
			<input type="text" class="form-control"  name="${it.dataName}" id="${it.dataName}" placeholder="请输入${column.cnname}" maxlength="${it.length}" value="\$!{${varDomainName}.${it.dataName}}"<%
				if(column.getIsPK()){
					print "readonly"
				}
				print("/>");
					
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
	<a href="javascript:;" class="btn btn-primary" id="btn_update_${tableDefine.id}">保存修改</a>
	<a href="javascript:;" class="btn btn-sm" onclick="backToManage();">返回</a>
</div>


<script language="javascript">




void function(j) {
	var set = {
		 <%
			def listSize=tableModel.listSize('updateList');
		 	int i=0;
			columns.each{
			  def column=it;
			  if(tableModel.isNotInList('updateList',column.columnName)){
				return ;
			  }
		    print snippetTemplateUtil.getTemplate(column,'form_rule_item');
		 	i++;
			if(i<listSize) println ',';
			
		}	
		%>
	};
	

	j('#btn_update_${tableDefine.id}').click(function(e) {
		gUtils.fSubmitForm(
			j("#form_update_${tableDefine.id}").serialize(),
			set, 
			'${urlPrefix}/doUpdate.action', 
			function() {
				gDialog.fClose();
				backToManage();
			}
		);
	});


	//form.friend.init(set);
}(jQuery);


	function backToManage(){
    		var url='${urlPrefix}/manage.action';
			url=gUtils.fMakeFullLink(url);
            window.location=url;
    };
</script>