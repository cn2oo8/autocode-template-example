<%
   def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def urlPrefix="/"+PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category),"/")+varDomainName;
  urlPrefix=urlPrefix.replace("//","/");
  def pkColumn=tableDefine.getPkColumn();

%>#set(\$layout='/WEB-INF/vm/layout/adminLayout.vm')
<%
  def containerId='search_'+varDomainName.toLowerCase();
  def requireInfo=requireUtil.getRequireInfo(tableModel,'searchKeys');
  if(requireInfo.hasModule()){
  	 def dataMap=["requireInfo":requireInfo,"containerId":containerId];
	if(extendConf['requirejs']=='true'){
	 println snippetTemplateUtil.getTemplateByMap(dataMap,'requireJsScript');
	}else{
	   println requireUtil.getRequireInfo(tableModel,'allColumn').getRequireText();
	   println snippetTemplateUtil.getTemplateByMap(dataMap,'elementInit');
	}
  }
%>


<div class="manage-content" id="${containerId}">

<form class="form-inline" id="search_form_${tableDefine.id}">
<% List<String> list=tableModel.getSearchKeyList();
   if(list.size()!=0)
 	{
 	list.each{
		def column=tableDefine.getColumnByColumnName(it);
		if(column==null) return;
		%>

		<div class="form-group">
			<label for="${column.dataName}_search">${column.cnname}</label>
				<%
				if("Select".equalsIgnoreCase(column.jspTag)){
						  println dictUtil.getDictTemplate(column,"dict-searchPage-disp");
					}else if("date".equalsIgnoreCase(column.jspTag)){
						%>
						<input type="text"  name="${column.dataName}" id="${column.dataName}_search" class="form-control input-medium  j_date_picker" placeholder="请输入${column.cnname}">
						<%
					}else if("datetime".equalsIgnoreCase(column.jspTag)){
                     	%>
                     	<input type="text"  name="${column.dataName}" id="${column.dataName}_search" class="form-control j_datetime_picker" placeholder="请输入${column.cnname}">
                     	<%
                    }else {%>
				<input type="text"  name="${column.dataName}" id="${column.dataName}_search" class="form-control" placeholder="请输入${column.cnname}">
				<%
				}
				%>
		</div>&nbsp;&nbsp;
		<% 
		}
		%>
		<input type="button" onclick="query${tableDefine.id}List();" class="btn btn-primary" value="搜索"  />
	</form>
		<%
	}
%>
<br/>



		 <div class="page_operate">
			 <button class="btn  btn-primary" type="button" id="add-${varDomainName}">
				<span class="glyphicon glyphicon-plus"></span> 创建 ${tableDefine.cnname}</button>
		</div>


	<div id="dl_${tableDefine.id}"></div>
</div>


<script language="javascript">

	function query${tableDefine.id}List(pageNo) {
		if (!pageNo) {
			pageNo = 1;
		}
		var page = pageNo;
		var url = '${urlPrefix}/list.action';
		var param = {
			page: page
		};
		
		var pageSize=jQuery("#JPageSize_queryList").val();
        if(pageSize && !isNaN(pageSize)){
            param['pageSize']=pageSize;
        }

		gUtils.fMergeParam(param,"search_form_${tableDefine.id}");
		gUtils.fGetHtml(url, 'dl_${tableDefine.id}', param,'数据加载中...');
	}
	query${tableDefine.id}List();
	




void function(j) {
	jQuery("#add-${varDomainName}").click(function(){
		var url='${urlPrefix}/add.action';
		url=gUtils.fMakeFullLink(url);
		window.location=url;
	});
	
}(jQuery);

</script>