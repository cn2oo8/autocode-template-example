<%
  def columns=tableDefine.columns
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)
  def urlPrefix=PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category),".")+varDomainName
%>
<template>
	<div>
		<Modal v-model="showModal"
			   title="修改${tableDefine.cnname}"
			   @on-ok="save"
			   @on-cancel="cancel">
			<Form ref="formItems" :model="formItems" :rules="formRules"  :label-width="120" inline>

                <% columns.each{
                    def column=it;

                    if(tableModel.isNotInList('updateList',column.columnName)){
                        return ;
                    }
                    if(column.getIsPK()){
                %>
                <Row>
                    <Col span="24">
                    <Form-item label="${column.cnname}" prop="${column.dataName}" style="width: 90%">
                        <Input v-model="formItems.${column.dataName}" :maxlength="${column.length}" :disabled="true"></Input>
                    </Form-item>
                </Col>
                </Row>
                <%
                    }else{
                %>
                <Row>
                    <Col span="24">
                    <Form-item label="${column.cnname}" prop="${column.dataName}" style="width: 90%">
                        <Input v-model="formItems.${column.dataName}" :maxlength="${column.length}" :disabled="disableInput"></Input>
                    </Form-item>
                </Col>
                </Row>
                <%
                    }
                }
                %>
			</Form>
			<div slot="footer">
				<Button type="default" @click="cancel">取消</Button>
				<Button type="primary" @click="save" :loading="loading"><Icon type="android-done"></Icon> 保存</Button>
			</div>
		</Modal>

	</div>
</template>

<script>
    import constants from '@/constants/constants.js'
    import requestUtils from '@/request/requestUtils.js'
    var _ = require('underscore')

    var validateSet = {
        <%
			def listSize=tableModel.listSize('updateList');
		 	int i=0;
			columns.each{
			  def column=it;
			  if(tableModel.isNotInList('updateList',column.columnName)){
				return ;
			  }
			  if(column.getIsPK()){
			  	i++;
				return ;
			  }

		    print snippetTemplateUtil.getTemplate(column,'form_rule_item_vue');
		 	i++;
			if(i<listSize) println ',';

		}
		%>
    };
    export default {
        data () {
            return {
                formItems: {},
                formRules: validateSet,
               // formRules: constants.rules.${varDomainName}.edit,
                showModal: false,
                loading: false,
                disableInput: false
            }
        },

        methods:{
            save: function () {
                this.\$refs['formItems'].validate((valid) => {
                    if (!valid) {
                    return false
                }
                requestUtils.postSubmit(this, constants.urls.${urlPrefix}.update, this.formItems, function (data) {
                    this.\$Message.success({
                        content: '修改成功',
                        duration: 3
                    })
                    this.showModal = false
                    this.\$emit(constants.actions.common.refreshList)
                })
            })
            },
            'cancel': function () {
                this.\$refs['formItems'].resetFields()
                this.showModal = false
            },
            'show': function (isShow) {
                this.showModal = isShow
            },
            'editItem': function (item) {
                this.formItems = _.clone(item)
                this.show(true)
            }
        }
    }
</script>