<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="utf-8">
	<title>借书还书</title>
	<link href="http://v3.bootcss.com/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>

</head>
<body>

<div class="bs-example" id="table">
	<table class="table table-striped">
        <div class="input-group">
            <input type="text" class="form-control" id="findName">
            <span v-on:click="findItem()" class="input-group-addon">搜索</span>
			<span class="input-group-addon" v-on:click="creatItem()">新增</span>
        </div>
		<!-- 新增模态框（Modal） -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">新增图书</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="txt_departmentname">图书名称</label>
							<input v-model="BookData.name" type="text" name="txt_departmentname" class="form-control" id="txt_departmentname" placeholder="图书名称">
						</div>
						<div class="form-group">
							<label for="txt_parentdepartment">图书数量</label>
							<input v-model="BookData.number"type="text" name="txt_parentdepartment" class="form-control" id="txt_parentdepartment" placeholder="图书数量">
						</div>
                        <div class="form-group">
                            <label for="txt_parentdepartment">已借出数量</label>
                            <input v-model="BookData.lendNumber"type="text" name="txt_parentdepartment" class="form-control"  placeholder="已借出数量">
                        </div>
						<div class="form-group">
							<label for="txt_departmentlevel">图书详情</label>
							<input v-model="BookData.detail" type="text" name="txt_departmentlevel" class="form-control" id="txt_departmentlevel" placeholder="图书详情">
						</div>
						<div class="form-group">
							<label for="txt_departmentlevel">图书状态</label>
							<input v-model="BookData.isLend" type="text" name="txt_departmentlevel" class="form-control"  placeholder="图书状态">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭
							</button>
							<button type="button" class="btn btn-outline-primary" data-dismiss="modal" v-on:click="addRow">确认</button>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- 新增模态框（Modal） end-->
		<!-- 编辑模态框（Modal） -->
		<div class="modal fade" id="updateMyModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">编辑图书</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="txt_departmentname">图书名称</label>
							<input v-model="BookData.name" type="text" name="txt_departmentname" class="form-control"  placeholder="图书名称">
						</div>
						<div class="form-group">
							<label for="txt_parentdepartment">图书数量</label>
							<input v-model="BookData.number"type="text" name="txt_parentdepartment" class="form-control"  placeholder="图书数量">
						</div>
                        <div class="form-group">
                            <label for="txt_parentdepartment">已借出数量</label>
                            <input v-model="BookData.lendNumber"type="text" name="txt_parentdepartment" class="form-control"  placeholder="已借出数量">
                        </div>
						<div class="form-group">
							<label for="txt_departmentlevel">图书详情</label>
							<input v-model="BookData.detail" type="text" name="txt_departmentlevel" class="form-control"  placeholder="图书详情">
						</div>
						<div class="form-group">
							<label for="txt_departmentlevel">图书状态</label>
							<input v-model="BookData.isLend" type="text" name="txt_departmentlevel" class="form-control" id="txt_isLend" placeholder="图书状态">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭
							</button>
							<button type="button" class="btn btn-outline-primary" data-dismiss="modal" v-on:click="updateRow">确认</button>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- 编辑模态框（Modal） end-->

		<thead>
		<tr>
			<th>id</th>
			<th>图书名称</th>
			<th>数量</th>
            <th>已借出数量</th>
			<th>详情</th>
			<th>图书状态</th>
		</tr>
		</thead>
		<tbody>
		<tr v-if="listData.length>0"  v-for="item in listData">
			<th scope="row">{{item.id}}</th>
			<td>{{item.name}}</td>
			<td>{{item.number}}</td>
            <td>{{item.lendNumber}}</td>
			<td>{{item.detail}}</td>
			<td>{{item.isLend}}</td>
			<td>
				<button v-on:click="editItem(item.id)" class="btn btn-default" >借书</button>
				<button v-on:click="deleteItem(item.id)" class="btn btn-default" >还书</button>
			</td>
		</tr>
		<tr>
			<td colspan=3>
				<div id="pagelist">
					<div class="row">
						<div class="col-sm-6" style="line-height: 80px">
							<div class="dataTables_info" id="sample-table-2_info">
								共{{pageData.total}}条，当前显示第
								<span v-if="pageData.pageSize==1 || pageData.total == 0 || pageData.total == 1">
                                                {{pageData.itemStart}}</span>
								<span v-else>{{pageData.itemStart}}-{{pageData.itemEnd}}</span>
								条
							</div>
						</div>
						<div class="col-sm-6">
							<div class="dataTables_paginate paging_bootstrap">
								<ul class="pagination">
									<li v-if="pageData.curPage == 1 || pageData.total == 0 || pageData.total == 1" class="prev disabled">
										<a>首页</a>
									</li>
									<li v-else class="prev">
										<a href="javascript:void(0)" v-on:click="changeCurPage(1,pageData.pageSize);">
											首页
										</a>
									</li>
									<li v-if="pageData.curPage == 1 || pageData.total == 0 || pageData.total == 1" class="prev disabled">
										<a>上一页</a>
									</li>
									<li v-else class="prev">
										<a href="javascript:void(0)" v-on:click="changeCurPage(pageData.curPage-1,pageData.pageSize);">
											上一页</i>
										</a>
									</li>
									<li v-if="pageData.totalPage > 5 && pageData.curPage > 3" class="next disabled">
										<a>...</a>
									</li>
									<template v-for="pageItem in pageData.pageIndex">
										<li v-if="pageData.curPage == pageItem" class="active">
											<a>{{pageItem}}</a>
										</li>
										<li v-else>
											<a href="javascript:void(0)" v-on:click="changeCurPage(pageItem,pageData.pageSize);">
												{{pageItem}}
											</a>
										</li>
									</template>
									<li v-if="pageData.totalPage > 5 && pageData.curPage < pageData.totalPage-2" class="next disabled">
										<a>...</a>
									</li>
									<li v-if="pageData.curPage == pageData.totalPage || pageData.total == 0 || pageData.total == 1" class="next disabled">
										<a>下一页</a>
									</li>
									<li v-else class="next">
										<a href="javascript:void(0)" v-on:click="changeCurPage(pageData.curPage+1,pageData.pageSize);">
											下一页
										</a>
									</li>
									<li v-if="pageData.curPage == pageData.totalPage || pageData.total == 0 || pageData.total == 1" class="next disabled">
										<a>末页</a>
									</li>
									<li v-else class="next">
										<a href="javascript:void(0)" v-on:click="changeCurPage(pageData.totalPage,pageData.pageSize);">
											末页
										</a>
									</li>
									<template v-if="pageData.totalPage > 5" class="next disabled">
										<li>
											<input value="" ref="goPage" class="input-mini" type="text" style="height: 32px;width:40px;margin:auto 5px auto 20px;line-height: 24px;">
											<label><a href="javascript:void(0)" v-on:click="goPage(pageData.pageSize,pageData.totalPage)">Go</a></label>
										</li>
									</template>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</td>
		<tr>
		</tbody>
	</table>
</div>



<script type="text/javascript">
    var $returnData;
    function getData($page,$pageSize){
        var findName = $('#findName').val();
        var updateId=0;
        $.ajax({
            type: "post",  //post put get 等等
            url: "../book/getList?t="+new Date().getTime(),
            async:false,
            dataType:"json",
            data: {
                "page": $page,
                "pageSize": $pageSize,
				"findName":findName
            },
            success: function (data) {
                if(0 != data.total){
                    $returnData = {'data':data.list,'total':data.total};
                } else{
                    alert("没有数据");
                }

            },

        });
    }


    var vm = new Vue({
        el: '#table',
        data: {
            listData:[],
            page: 1,//当前页码
            pageSize: 10,//每页条数
            total:0,//总数
            pageData: {
                curPage: 1,
                pageSize: 10,
                total: 0,
                totalPage: 0,
                pageIndex: [],
                itemStart: 0,
                itemEnd: 0
            },
            BookData:{
                name:"",
				number:0,
				detail:"",
				isLend:"",
                lendNumber:0
			}
        },
        methods:{
            listItems: function () {//列出需要的数据
                getData(this.page,this.pageSize);
                var returnData = $returnData;
                this.listData = returnData.data;
                this.total=returnData['total'];
                this.setPageList(this.total, this.page, this.pageSize);
            },
            editItem:function ($id) {//借书操作在这儿哟
                updateId=$id;
                alert("借书");
                this.$http.post('../book/toLendBook',{id:$id},{emulateJSON:true}).then(function(res){
                    if (res.body.msg=="借书成功"){
                        alert("借书成功");
                    } else{
                        alert(res.body.msg);
                    }
                    vm.listItems();
                },function(res){
                    console.log(res.status);
                });
            },
            deleteItem:function ($id) {//还书
                alert('还书第'+$id+'条数据！');
                this.$http.post('../book/toYetBook',{id:$id},{emulateJSON:true}).then(function(res){
                    if (res.body.msg=="还书成功"){
                        alert("还书成功");
                    } else{
                        alert("还书失败");
                    }
                    vm.listItems();
                },function(res){
                    console.log(res.status);
                });
            },
            updateRow:function(){

                alert('编辑第'+updateId+'条数据！');
                this.$http.post('../book/toUpdateBook',{id:updateId,name:this.BookData.name,number:this.BookData.number,detail:this.BookData.detail,isLend:this.BookData.isLend,lendNumber:this.BookData.lendNumber},{emulateJSON:true}).then(function(res){
                    if (res.body.msg=="更改成功"){
                        alert("编辑成功");
                    } else{
                        alert("编辑失败");
                    }
                    vm.listItems();
                    this.BookData.name="";
                    this.BookData.number=0;
                    this.BookData.detail="";
                    this.BookData.isLend="";
                    this.BookData.lendNumber=0;
                },function(res){
                    console.log(res.status);
                });

			},
            findItem:function(){
                var findName = $('#findName').val();
                alert('模糊查询'+findName);
                vm.listItems();
                $('#findName').val("")
            },
			creatItem:function(){
				$('#myModal').modal('show');
			},
            addRow:function(){
              alert(this.BookData.name+"");
                this.$http.post('../book/toAddBook',{name:this.BookData.name,number:this.BookData.number,detail:this.BookData.detail,isLend:this.BookData.isLend,lendNumber:this.BookData.lendNumber},{emulateJSON:true}).then(function(res){
                   if (res.body.msg=="添加成功"){
                       alert("添加成功");
				   } else{
                       alert("添加失败");
				   }
                    vm.listItems();
                   this.BookData.name="";
                   this.BookData.number=0;
                   this.BookData.detail="";
                   this.BookData.isLend="";
                   this.BookData.lendNumber=0;
               },function(res){
                    console.log(res.status);
                });
			},
            setPageList: function (total, page, pageSize) {
                total = parseInt(total);
                var curPage = parseInt(page);
                pageSize = parseInt(pageSize);
                var totalPage = Math.ceil(total / pageSize);
                var itemStart = (curPage - 1) * pageSize + 1;
                if (curPage == totalPage) {
                    itemEnd = total;
                } else {
                    itemEnd = curPage * pageSize;
                }
                var pageIndex = [];
                if (curPage >= 1 && curPage <= totalPage) {
                    if (totalPage < 5) {//5页以内
                        for (var $i = 1; $i <= totalPage; $i++) {
                            pageIndex.push($i);
                        }
                    } else {//大于5页
                        if (curPage == 1) {
                            pageIndex = [curPage, curPage + 1, curPage + 2, curPage + 3, curPage + 4];
                        } else if (curPage == 2) {
                            pageIndex = [curPage - 1, curPage, curPage + 1, curPage + 2, curPage + 3];
                        } else if (curPage == totalPage - 1) {
                            pageIndex = [curPage - 3, curPage - 2, curPage - 1, curPage, totalPage];
                        } else if (curPage == totalPage) {
                            pageIndex = [curPage - 4, curPage - 3, curPage - 2, curPage - 1, curPage];
                        } else {
                            pageIndex = [curPage - 2, curPage - 1, curPage, curPage + 1, curPage + 2];
                        }
                    }
                }

                this.pageData.curPage = curPage;
                this.pageData.pageSize = pageSize;
                this.pageData.total = total;
                this.pageData.totalPage = totalPage;
                this.pageData.pageIndex = pageIndex;
                this.pageData.itemStart = itemStart;
                this.pageData.itemEnd = itemEnd;
            },
            changeCurPage: function (page, pageSize) {//换页
                this.page = page;
                this.pageSize = pageSize;
                this.listItems();
            },
            goPage: function (pageSize, totalPage) {//跳转页
                var pageIndex = this.$refs.goPage.value;
                if (pageIndex <= 0) {
                    pageIndex = 1;
                    this.$refs.goPage.value = 1;
                } else if (pageIndex >= totalPage) {
                    pageIndex = totalPage;
                    this.$refs.goPage.value = totalPage;
                }
                this.changeCurPage(pageIndex, pageSize);
            }
        }
    });

    window.onload = function(){
        vm.listItems();

        console.log('Hello World!');

    };
</script>
</body>
</html>