<template>
    <div>
        <el-container>
            <el-header>
                <h5>jujin8导航管理</h5>
                <el-radio-group v-model="radio" style="float: right;padding-bottom: 10px" @change="filterData">
                <el-radio-button label="全部"></el-radio-button>
                <el-radio-button label="顶部导航"></el-radio-button>
                <el-radio-button label="底部链接"></el-radio-button>
                </el-radio-group>
            </el-header>
            <el-main>
                <el-table
                        :data="menu_lists"
                        border
                        style="width: 100%"
                        v-loading="loading">
                    <el-table-column
                            prop="id"
                            :label="columns['id']['title']"
                            v-if="columns['id']['show']"
                            width="50">
                    </el-table-column>
                    <el-table-column
                            prop="name"
                            :label="columns['name']['title']"
                            v-if="columns['name']['show']"
                            width="100">
                    </el-table-column>
                    <el-table-column
                        prop="url"
                        :label="columns['url']['title']"
                        v-if="columns['url']['show']"
                        width="150">
                </el-table-column>
                    <el-table-column
                            prop="area"
                            :label="columns['area']['title']"
                            v-if="columns['area']['show']"
                            width="150">
                    </el-table-column>
                    <el-table-column
                            prop="state"
                            :label="columns['state']['title']"
                            v-if="columns['state']['show']"
                            width="120">
                        <template slot-scope="scope">
                            <el-switch v-model="scope.row.state"
                                       :disabled="!user_module_permission['feedback-delete']"
                                       @change="changeState(scope.row)"></el-switch>
                        </template>
                    </el-table-column>
                    <el-table-column
                            prop="sequence"
                            :label="columns['sequence']['title']"
                            v-if="columns['sequence']['show']"
                            width="100">
                    </el-table-column>
                    <el-table-column
                            prop="created_at"
                            :label="columns['created_at']['title']"
                            v-if="columns['created_at']['show']">
                    </el-table-column>
                    <el-table-column
                            prop="updated_at"
                            :label="columns['updated_at']['title']"
                            v-if="columns['updated_at']['show']">
                    </el-table-column>
                    <el-table-column
                            label="操作"
                            width="300">
                        <template slot-scope="scope">
                            <el-button
                                    size="mini"
                                    :type="scope.row.state?'success':'danger'"
                                    :disabled="!user_module_permission['hot-banner-delete']"
                                    @click="setState(scope.$index, scope.row)">{{scope.row.state==1?"下线":"上线"}}</el-button>
                            <el-button
                                    size="mini"
                                    :type="scope.row.state?'success':'danger'"
                                    :disabled="!user_module_permission['hot-banner-delete']"
                                    @click="edithot_banner(scope.$index, scope.row)">编辑</el-button>
                        </template>
                    </el-table-column>

                </el-table>
                <!--<el-pagination-->
                        <!--background-->
                        <!--@current-change="page_change"-->
                        <!--@size-change="size_change"-->
                        <!--:current-page="current_page"-->
                        <!--layout="total, sizes, prev, pager, next, jumper"-->
                        <!--:total="total"-->
                        <!--style="margin-top: 40px"-->
                <!--&gt;-->
                <!--</el-pagination>-->
            </el-main>
        </el-container>
    </div>
</template>

<script>
    import {mapState, mapActions, mapMutations, mapGetters} from 'vuex'
    import {Table, TableColumn, Pagination, Loading, Radio,RadioGroup,RadioButton,Popover,  Dialog, FormItem, Input, Select, Option, Switch, DatePicker, Upload, Form} from 'element-ui'
    Vue.use(Table);
    Vue.use(TableColumn);
    Vue.use(Pagination);
    Vue.use(Loading);
    Vue.use(RadioGroup);
    Vue.use(Radio);
    Vue.use(RadioButton);
    export default {
        name: "main-menu",
        data() {
            return {
                loading: false,
                radio:"全部"
            }
        },

        computed: {
            ...mapState(['headers', 'formLabelWidth']),
            ...mapState({
                'columns': state=>state.menu.columns,
                'menu_lists': state=>state.menu.menu_lists,
                'user_module_permission': state=>state.user.user_module_permission,
                'current_page':state=>state.menu.currentPage,
                'total':state=>state.menu.total
            })
        },
        methods:{
            ...mapMutations({
                'set_state':'menu/set_state',
                'set_feed_state': "menu/set_feed_state",
                'filter_data':"menu/filter_data"
            }),
            ...mapActions({
                'get_lists': 'menu/get_lists'
            }),
            //深拷贝
            deepCopy:function (p, c){
                var c = c || {};
                for (var i in p) {
                    if (typeof p[i] === 'object') {
                        c[i] = (p[i].constructor === Array) ? [] : {};
                        deepCopy(p[i], c[i]);
                    } else {
                        c[i] = p[i];
                    }
                }
                return c;
            },
            //更改handle状态
            changeState: function (row) {
                const _this = this;

                // const obj=this.deepCopy(row);
                // obj.is_handling=row.is_handling?1:0;
                // this.set_feed_state(obj).then(result=>{
                //     _this.$message.success("更新成功");
                // });
            },
            //筛选处理未处理
            filterData:function (state) {
                let _this=this;
                let param="";
                switch (state){
                    case "全部":param=0;break;
                    case "顶部导航":param=1;break;
                    case "底部链接":param=2;break;
                }
                this.filter_data(param);
                // this.set_feed_state(s);
                // this.get_lists().then(result=> {
                //     _this.loading=false;
                // });

            }
        },
        mounted(){
            //获取导航列表
            var _this=this;
            this.get_lists().then(result=> {
                _this.$message.success('成功获取导航列表！');
            })
        }
    }
</script>

<style scoped>

</style>