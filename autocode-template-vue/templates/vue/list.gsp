<%
    def columns=tableDefine.columns
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)
    def urlPrefix=PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category),".")+varDomainName

%>
<template>
	<div>

		<Form ref="formSearch" :model="formSearch" :rules="searchFormRules" :label-width="80">
        <%
            List<String> list=tableModel.getSearchKeyList();
            def listSize=list.size()
            int i=0;
            list.each{
                if(i%4 == 0){
                    println "<Row>"
                }
                def column=tableDefine.getColumnByColumnName(it);


                if("Select".equalsIgnoreCase(column.jspTag)) {%>
                <Col span="6">
                    <FormItem label="${column.cnname}" prop="${column.dataName}">
                        <dict-select v-model="formSearch.${column.dataName}" :kind="this.constants.dicts.dictKinds.${column.dictName}" :clearable="true"></dict-select>
                    </FormItem>
                </Col>
                <%}else {
                %>
                <Col span="6">
                    <FormItem label="${column.cnname}" prop="${column.dataName}">
                        <Input v-model="formSearch.${column.dataName}" placeholder="请输入${column.cnname}"></Input>
                    </FormItem>
                </Col>
            <%

                }

                i++;
                if(i%4 == 0 || i== list.size() ){
                    println "</Row>"
                }
            }
        %>
			<Row>
				<Col span="4" offset="20">
				<Form-item>
					<Button type="primary" @click="loadPageNoChange(1)" :loading="loading">			<Icon type="search"></Icon>
                        查询</Button>
				</Form-item>
			</Col>
			</Row>

		</Form>


		<add v-on:refreshList="loadData()"></add>
		<edit ref="editModal" v-on:refreshList="loadData()"></edit>

		<Table border :columns="columns" :data="queryResult.dataList" :loading="loading">
            <template slot-scope="{ row, index }" slot="operateSlot">
                <Button type="primary" size="small" @click="editItem(row)">
                    <Icon type="edit"></Icon>
                    修改
                </Button>
                <Button type="error" size="small" @click="doDelete(row)">
                    <Icon type="trash-a"></Icon>
                    删除
                </Button>
            </template>
        </Table>

		<div style="margin: 10px;overflow: hidden">
			<div style="float: right;">
				<Page :total="queryResult.pageQuery.totalCount" :pageSize="queryResult.pageQuery.pageSize"
					  :current="queryResult.pageQuery.currentPageNo" @on-page-size-change="loadPageSizeChange"
					  @on-change="loadPageNoChange" show-total show-elevator show-sizer></Page>
			</div>
		</div>
	</div>
</template>
<script>
    import add from './add.vue';
    import edit from './edit.vue';
    import dictSelect from '@/view/components/dict/DictSelect'
    import dictCheckbox from '@/view/components/dict/DictCheckBox'
    import dictRadio from '@/view/components/dict/DictRadio'

    import tableDefine from './tableDefine.js'
    import * as renderUtil from '@/libs/renderUtil.js'
    import requestUtils from '@/request/requestUtils.js'
    import constants from '@/constants/constants';

    export default {
        mixins: [tableDefine],
        methods: {
            loadPageSizeChange(pageSize) {
                this.queryResult.pageQuery.pageSize = pageSize
                this.loadData()
            },
            loadPageNoChange(pageNo) {
                this.queryResult.pageQuery.currentPageNo = pageNo
                this.loadData()
            },
            loadData() {
                var _this = this

                this.\$refs['formSearch'].validate((valid) => {
                    if (valid) {
                        var searchParam = requestUtils.serializeObject(this.formSearch, true, true)
                        searchParam['pageSize'] = _this.queryResult.pageQuery.pageSize;
                        searchParam['page'] = _this.queryResult.pageQuery.currentPageNo;
                        requestUtils.postSubmit(_this, constants.urls.${urlPrefix}.list, searchParam, function (data) {
                            _this.queryResult.dataList = data.value
                            _this.queryResult.pageQuery = data.pageQuery
                        }, null, true)
                    } else {
                        this.\$Message.error('Fail!');
            }
            })
            },
            editItem: function (item) {
                this.\$refs.editModal.editItem(item)
            },
            doDelete(row) {
                var _this = this;
                var params = { 'primaryKey': row.id }
                this.\$Modal.confirm({
                    title: '删除确认',
                    content: '您确定要执行删除操作吗？',
                    onOk: function() {
                    requestUtils.postSubmit(this, constants.urls.${urlPrefix}.delete, params, function (data) {
                        _this.\$Message.success({
                            content: '删除成功',
                            duration: 3
                        })
                        _this.loadData();
                    })
                };
            });
            }
        },
        components: {
            add,
            edit,
            dictSelect,
            dictCheckbox,
            dictRadio
        }
    }

</script>