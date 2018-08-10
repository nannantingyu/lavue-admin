<template>
    <div>
        <el-header>
            <h5>jujin8待审核文章管理</h5>
            <div style="overflow: hidden">
                <template>
                    <el-select v-model="optionValue" placeholder="请选择网站来源" value-key="site" filterable  style="float: right;">
                        <el-option
                                v-for="(item,index) in options"
                                :key="'option'+index"
                                :label="item.site+'（'+item.time+'）'"
                                :value="item">
                        </el-option>
                    </el-select>
                </template>
                <el-popover
                        placement="right"
                        width="400"
                        trigger="click">
                    <ul class="switch-panel">
                        <li v-for="(i, k) in columns">
                            <el-switch
                                    v-model="i.show"
                                    :active-text="i.title">
                            </el-switch>
                        </li>
                    </ul>
                    <el-button slot="reference">显示隐藏列</el-button>
                </el-popover>
                <!--<el-radio-group v-model="radio" style="float: right;" @change="filterData">-->
                    <!--<el-radio-button label="全部"></el-radio-button>-->
                    <!--<el-radio-button label="自动审核"></el-radio-button>-->
                    <!--<el-radio-button label="人工审核"></el-radio-button>-->
                <!--</el-radio-group>-->
            </div>
        </el-header>
        <el-main>
            <el-table :data="article_lists.slice((current_page-1)*per_page, current_page*per_page)"
                      v-loading="loading"
                      @sort-change="changeTableSort"
                      style="width: 100%">
                <el-table-column
                        prop="id"
                        sortable
                        :label="columns['id']['title']"
                        v-if="columns['id']['show']"
                        width="80">
                </el-table-column>
                <el-table-column
                        :label="columns['title']['title']"
                        v-if="columns['title']['show']" width="*">
                    <template slot-scope="scope">
                        <a target="_blank" v-bind:href="scope.row.url">{{ scope.row.title }}</a>
                    </template>
                </el-table-column>
                <el-table-column
                        prop="image"
                        :label="columns['image']['title']"
                        v-if="columns['image']['show']"
                        width="160">
                    <template slot-scope="scope">
                        <img width="140" :src="transfer(scope.row.image)" :alt="scope.row.image">
                    </template>
                </el-table-column>
                <el-table-column
                        prop="url"
                        :label="columns['url']['title']"
                        v-if="columns['url']['show']"
                        width="140">
                    <template slot-scope="scope">
                        <a target="_blank" v-bind:href="scope.row.url">{{ scope.row.url }}</a>
                    </template>
                </el-table-column>
                <el-table-column
                        prop="state"
                        sortable
                        :label="columns['state']['title']"
                        v-if="columns['state']['show']"
                        width="80">
                    <template slot-scope="scope">
                        <el-switch
                                :disabled="!user_module_permission['article-delete']"
                                v-model="scope.row.state"
                                @change="changeState(scope.$index, scope.row)"></el-switch>
                    </template>
                </el-table-column>
                <el-table-column
                        prop="source_type"
                        :label="columns['source_type']['title']"
                        v-if="columns['source_type']['show']"
                        width="80">
                </el-table-column>
                <el-table-column
                        prop="source_url"
                        :label="columns['source_url']['title']"
                        v-if="columns['source_url']['show']"
                        width="80">
                    <template slot-scope="scope">
                        <a target="_blank" v-bind:href="scope.row.source_url">来源</a>
                    </template>
                </el-table-column>
                <el-table-column
                        prop="source_site"
                        :label="columns['source_site']['title']"
                        v-if="columns['source_site']['show']"
                        width="80">
                </el-table-column>
                <el-table-column
                        prop="created_at"
                        sortable
                        :label="columns['created_at']['title']"
                        v-if="columns['created_at']['show']"
                        width="120">
                </el-table-column>
                <el-table-column
                        prop="updated_at"
                        sortable
                        :label="columns['updated_at']['title']"
                        v-if="columns['updated_at']['show']"
                        width="120">
                </el-table-column>
                <el-table-column prop="author"
                                 :label="columns['author']['title']"
                                 v-if="columns['author']['show']" width="180">
                </el-table-column>
                <el-table-column
                        prop="publish_time"
                        sortable
                        label="发布时间"
                        width="180">
                </el-table-column>

                <el-table-column label="操作" fixed="right" width="140">
                    <template slot-scope="scope">
                        <router-link :class="'router-button'" :to="'/article-edit/'+scope.row.id">编辑</router-link>
                        <el-button
                                size="mini"
                                :type="scope.row.state?'success':'danger'"
                                :disabled="!user_module_permission['article-delete']"
                                @click="drop_article(scope.$index, scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination
                    background
                    @current-change="page_change"
                    @size-change="size_change"
                    :current-page="current_page"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="total">
            </el-pagination>
        </el-main>
    </div>
</template>

<script>
    import {mapState, mapActions, mapMutations, mapGetters} from 'vuex'
    import {
        Table,
        TableColumn,
        Radio,
        RadioGroup,
        RadioButton,
        Select,
        Option,
        Pagination, Loading, Popover, Switch, Input,
    } from 'element-ui';

    Vue.use(Table);
    Vue.use(TableColumn);
    Vue.use(Radio);
    Vue.use(RadioGroup);
    Vue.use(RadioButton);
    Vue.use(Select);
    Vue.use(Option);
    Vue.use(Popover);
    Vue.use(Switch);
    Vue.use(Input);
    Vue.use(Loading);
    Vue.use(Pagination);
    export default {
        name: "article-need-look",
        data() {
            var p = this.$store.state.article_need_look.options[0];
            return {
                radio: "全部",
                optionValue: p.site
            }
        },
        computed:{
            ...mapState(['formLabelWidth']),
            ...mapState({
                'options':state =>state.article_need_look.options,
                'columns': state => state.article_need_look.columns,
                'article_lists': state=>state.article.article_lists,
                'loading': state=>state.article.loading,
                'total_page': state=>state.article.total_page,
                'current_page': state=>state.article.current_page,
                'per_page': state=>state.article.per_page,
                'total': state=>state.article.total,
                'user_module_permission': state=>state.user.user_module_permission,
                'article_categories': state=>state.article.article_categories,
                // 'lists': state => state.article_filter.lists,
                // 'user_module_permission': state => state.user.user_module_permission
            }),
            ...mapGetters({
                'type_filter': 'article/type_filter'
            }),
        },
        methods: {
            ...mapMutations({
                // 'set_state':'menu/set_state',
                // 'set_feed_state': "menu/set_feed_state",
                // 'filter_data':"menu/filter_data"
            }),
            ...mapActions({
                'get_options':'article_need_look/get_options',
                'get_lists': 'article_need_look/get_lists',
                // 'add_update':'menu/add_update'
            }),
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            changeState(row, index) {
                console.log(row, index, "nnnn")
            },
            filterData(state) {
                console.log(state)
            },
            get_article_list: function() {
                if(this.article_lists.length <= 0) {
                    const _this = this;
                    this.$store.dispatch('article/get_data').then(data => {
                        _this.$message.success("成功获取文章列表")
                    })
                }
            },
            // changeState: function(index, row) {
            //     const state = row.state?1:0;
            //     const new_state = state, _this = this, msg = new_state == 0?"下线":"上线";
            //     this.set_article_state({id: row.id, state: new_state, index: index})
            //         .then((x)=>{
            //             _this.$message.success(msg + "成功");
            //         }).catch((x)=>{
            //         _this.$message.error(msg + "失败");
            //     })
            // },
            drop_article: function(index, row) {
                const _this = this;
                MessageBox.confirm('此操作将永久删除该文件, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    _this.delete_article({id: row.id, index: index}).then(result=> {
                        _this.$message.success("删除成功");
                    })
                }).catch(() => {
                    _this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            filterHandler: function(value, row, column) {
                const property = column['property'];
                return row[property] == value;
            },
            page_change: function(page) {
                this.set_current_page(page)
            },
            size_change: function(size) {
                this.set_per_page(size);
            },
            transfer: function(img) {
                return img?'http://images.jujin8.com'+img.replace('/uploads/crawler', '/uploads'):''
            },
            changeTableSort: function(column) {
                const new_article_lists = this.article_lists.sort(function(x, y) {
                    const value1 = x[column['prop']], value2 = y[column['prop']];
                    let ret = 1;
                    if (/^\d+$/.test(value1)) {
                        ret = value1 - value2;
                    }
                    else {
                        ret = value1 > value2?1:-1;
                    }

                    return column['order'] === "ascending"?ret:-ret;
                });

                this.$store.commit('article/set_article_list', new_article_lists);
            }
        },
        mounted(){
            this.get_options().then(result=>{
               this.optionValue=result[0];
            });
            this.get_lists()

        }
    }
</script>

<style scoped>

</style>