<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def urlPrefix="/"+PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category),"/")+varDomainName;
  def columns=tableDefine.columns;
  urlPrefix=urlPrefix.replace("//","/");
  def pkColumn=tableDefine.getPkColumn();

%>
<div class="row-fluid">
	<div class="span12">
		<table class="table table-striped table-bordered table-hover table-condensed">
			<thead>
				<tr>
 <%	columns.each{
		def column=it;
		if(tableModel.isNotInList('queryList',column.columnName)){
			return ;
		  }
		  println "			<th><span>${it.cnname}</span></th>";
		  }
 %>
				<th class="operate">操作</th>
				</tr>
			</thead>


			<tbody>
	#if(\$list && \$list.size()!=0)
		    #foreach(\$item in \$list)
		   <tr>
				 <%		
			columns.each{
				def column=it;
				if(tableModel.isNotInList('queryList',column.columnName)){
					return ;
				  }

				if("Select".equalsIgnoreCase(it.jspTag)||"radio".equalsIgnoreCase(it.jspTag)||"checkbox".equalsIgnoreCase(it.jspTag))
				{
			         println "			<td>"+dictUtil.getDictTemplate(column,"dict-listPage-disp")+"</td>";
				}else if("Date".equalsIgnoreCase(it.jspTag))
				{
					println """			<td>\$!dateFormatUtils.format(\$!item.${it.dataName},'yyyy-MM-dd')</td>""";
				}else if("DateTime".equalsIgnoreCase(it.jspTag))
				{
					println "			<td>\$!dateFormatUtils.format(\$!item.${it.dataName})</td>";
				}else{
					println "			<td>\$!item.${it.dataName}</td>";
				 }
			  }
			  %>
				<td class="operate">
					<div class="visible-md visible-lg hidden-sm hidden-xs btn-group">
						<button class="btn btn-xs btn-success JUpdate-${varDomainName}" type="button" itemid="\$!item.${pkColumn.dataName}"><i class="icon-edit bigger-120"></i>编辑</button>
						<button class="btn btn-xs btn-info JView-${varDomainName}" type="button" itemid="\$!item.${pkColumn.dataName}"><i class="icon-eye-open bigger-120"></i>查看</button>
						<button class="btn btn-xs btn-danger JDelete-${varDomainName}" type="button" itemid="\$!item.${pkColumn.dataName}"> <i class="icon-trash bigger-120"></i>删除</button>
					</div>
				</td>
		  </tr>
			#end
		#else
		<tr>
					<td colspan="<%print columns.size()+1 %>" class="message_default">没有记录！</td>
		</tr>
		#end


			</tbody>


		</table>

		#if(\$pageQuery)
			#showPageQuery(\$pageQuery,'query${tableDefine.id}List','input')
		#end

	</div>
</div>




<script language="javascript">
void function(j) {	
	j('.JDelete-${varDomainName}').click(function() {
		var id = j(this).attr('itemid');
		var config={title:'删除${tableDefine.cnname}',info:'您确定要删除${tableDefine.cnname}吗？',"queryList":"query${tableDefine.id}List",
		url: '${urlPrefix}/doDelete.action',param:'${pkColumn.dataName}='+id};
		gUtils.fConfirmAndRefreshList(config);
	});
	
	j('.JUpdate-${varDomainName}').click(function() {
		var id = j(this).attr('itemid');
		//gDialog.fCreate({ title: '修改${tableDefine.cnname}', url: '${urlPrefix}/update.action?${pkColumn.dataName}='+id,width:700}).show();
		var url='${urlPrefix}/update.action?${pkColumn.dataName}='+id;
		window.location=gUtils.fMakeFullLink(url);
	});

	j('.JView-${varDomainName}').click(function() {
		var id = j(this).attr('itemid');
		//gDialog.fCreate({ title: '查看${tableDefine.cnname}', url: '${urlPrefix}/view?${pkColumn.dataName}='+id,width:700}).show();
		var url='${urlPrefix}/view.action?${pkColumn.dataName}='+id;
		window.location=gUtils.fMakeFullLink(url);
	});
}(jQuery);
</script>