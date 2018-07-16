<template>
    <div>
        <el-table :data="tableData"
                  v-loading="loading"
                  style="width: 100%">
            <el-table-column prop="id" label="ID" width="80"></el-table-column>
            <el-table-column label="标题" width="*">
                <template slot-scope="scope">
                    <a target="_blank" v-bind:href="'https://www.yjshare.cn/blog_' + scope.row.id">{{ scope.row.title }}</a>
                </template>
            </el-table-column>
            <el-table-column prop="author" label="作者" width="180"></el-table-column>
            <el-table-column prop="publish_time" label="发布时间" width="180"></el-table-column>
            <el-table-column label="操作" fixed="right" width="160">
                <template slot-scope="scope">
                    <router-link :class="'button button-small'" :to="'/article/'+scope.row.id">编辑</router-link>
                    <el-button size="mini" type="danger" @click="handleDelete()">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
                background
                @current-change="pageChange"
                @size-change="sizeChange"
                :current-page="currentPage"
                layout="total, sizes, prev, pager, next, jumper"
                :total="totalPage">
        </el-pagination>
    </div>
</template>

<script>
    import {Table, TableColumn, Pagination} from 'element-ui'
    Vue.use(Table);
    Vue.use(TableColumn);
    Vue.use(Pagination);
    import axios from 'axios';

    export default {
        name: "article-list-page",
        data() {
            return {
                tableData: [],
                loading: false,
                totalPage: 1,
                currentPage: 1,
                perPage: 10
            }
        },
        mounted() {
            this.getData();
        },
        methods: {
            getData: function() {
                let vm = this;
                vm.loading = true;
                axios.get("/api/article/lists", { params:
                        {
                            page: vm.currentPage,
                            num: vm.perPage
                        }
                    }).then(function(data){
                        vm.totalPage = data.data.last_page;
                        vm.currentPage = data.data.current_page;

                        vm.tableData = [];
                        data.data.data.forEach(function(d) {
                            vm.tableData.push({
                                publish_time: d['publish_time'],
                                author: d['author'],
                                title: d['title'],
                                id: d['id']
                            });
                        });

                        vm.loading = false;
                })
            },
            handleEdit: function() {

            },
            handleDelete: function() {

            },
            pageChange: function(page) {
                this.currentPage = page;
                this.getData();
            },
            sizeChange: function(size) {
                this.perPage = size;
                this.getData();
            }
        }
    }
</script>

<style scoped>
    .button{
        display: inline-block;
        line-height: 1;
        white-space: nowrap;
        cursor: pointer;
        background: #fff;
        border: 1px solid #dcdfe6;
        color: #606266;
        -webkit-appearance: none;
        text-align: center;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        outline: 0;
        margin: 0;
        -webkit-transition: .1s;
        transition: .1s;
        padding: 12px 20px;
        font-size: 14px;
        border-radius: 4px;
    }
    .button-small{
        padding: 7px 15px;
    }
</style>