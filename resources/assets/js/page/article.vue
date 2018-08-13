<template>
    <div>
        <el-row>
            <el-col :span="6">
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
            </el-col>
            <el-col :span="6">
                <el-radio-group v-model="show_type">
                    <el-radio-button label="3">全部</el-radio-button>
                    <el-radio-button label="1">上线</el-radio-button>
                    <el-radio-button label="0">下线</el-radio-button>
                </el-radio-group>
            </el-col>
            <el-col :span="4">
                <el-input v-model="search_key" placeholder="请输入搜索关键词" @change="get_article_list"></el-input>
            </el-col>
            <el-select v-model="sites" multiple placeholder="请选择来源站点" @change="get_article_list">
                <el-option
                    v-for="item in source_sites"
                    :key="item.name"
                    :label="item.name"
                    :value="item.name">
                </el-option>
            </el-select>
            <el-col :span="4">
                <el-select v-model="category" multiple placeholder="请选择分类" @change="get_article_list">
                    <el-option
                            v-for="item in article_categories"
                            :key="item.id"
                            :label="item.name"
                            :value="item.id">
                    </el-option>
                </el-select>
            </el-col>
        </el-row>
        <el-table :data="article_lists"
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
                    prop="description"
                    :label="columns['description']['title']"
                    v-if="columns['description']['show']"
                    width="250">
            </el-table-column>
            <el-table-column
                    prop="keywords"
                    :label="columns['keywords']['title']"
                    v-if="columns['keywords']['show']"
                    width="120">
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
                    prop="type"
                    :label="columns['type']['title']"
                    v-if="columns['type']['show']"
                    :filters="type_filter"
                    :filter-method="filterHandler"
                    width="120">
            </el-table-column>
            <el-table-column
                    prop="hits"
                    sortable
                    :label="columns['hits']['title']"
                    v-if="columns['hits']['show']"
                    width="100">
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
                    prop="favor"
                    sortable
                    :label="columns['favor']['title']"
                    v-if="columns['favor']['show']"
                    width="110">
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
    </div>
</template>

<script>
    import {mapState, mapActions, mapMutations, mapGetters} from 'vuex'
    import {Table, TableColumn, Pagination, MessageBox, Loading, Popover, Switch, RadioGroup, RadioButton, Input, Select, Option} from 'element-ui'
    Vue.use(Table);
    Vue.use(TableColumn);
    Vue.use(Pagination);
    Vue.use(Loading);
    Vue.use(Popover);
    Vue.use(Switch);
    Vue.use(RadioGroup);
    Vue.use(RadioButton);
    Vue.use(Input);
    Vue.use(Select);
    Vue.use(Option);

    export default {
        name: "article-list",
        created() {
            const _this = this;
            if(this.article_categories.length <= 0) {
                this.$store.dispatch("category/get_category_lists").then(result=> {
                    _this.set_article_categories(result);
                    _this.get_article_list();
                })
            }
            else {
                _this.get_article_list()
            }

            if(this.source_sites.length == 0) {
                this.$store.dispatch("config/get_config", {key: 'article_source_site'}).then(result=>{
                    if(result.data.success === 1) {
                        let sites = [];
                        for(let site of result.data.data.value) {
                            sites.push({'name': site['site']});
                        }

                        _this.set_source_sites(sites);
                    }
                });
            }
        },
        computed: {
            ...mapState({
                article_lists: state=>state.article.article_lists,
                source_sites: state=>state.article.source_sites,
                loading: state=>state.article.loading,
                total_page: state=>state.article.total_page,
                current_page: state=>state.article.current_page,
                per_page: state=>state.article.per_page,
                total: state=>state.article.total,
                columns: state=>state.article.columns,
                user_module_permission: state=>state.user.user_module_permission,
                article_categories: state=>state.article.article_categories,
            }),
            ...mapGetters({
                'type_filter': 'article/type_filter'
            }),
            show_type: {
                get() {
                    return this.$store.state.article.show_type
                },
                set(value) {
                    this.$store.commit('article/set_show_type', value)
                    this.filte_data()
                }
            },
            sites: {
                get() {
                    return this.$store.state.article.sites
                },
                set(value) {
                    this.$store.commit('article/set_sites', value)
                    this.filte_data()
                }
            },
            category: {
                get() {
                    return this.$store.state.article.category
                },
                set(value) {
                    this.$store.commit('article/set_category', value)
                    this.filte_data()
                }
            },
            search_key: {
                get() {
                    return this.$store.state.article.search_key
                },
                set(value) {
                    this.$store.commit('article/set_search_key', value)
                    this.filte_data()
                }
            },
        },
        methods: {
            ...mapMutations({
                set_current_page: "article/set_current_page",
                set_source_sites: "article/set_source_sites",
                set_per_page: "article/set_per_page",
                filte_data: "article/filte_data",
                set_article_categories: "article/set_article_categories",
                set_search_key: "article/set_search_key",
                filte_search: "article/filte_search",
                set_order_by: "article/set_order_by",
                set_order: "article/set_order",
                filter_by_category: "article/filter_by_category"
            }),
            ...mapActions({
                set_article_state: "article/set_article_state",
                delete_article: "article/delete_article"
            }),
            get_article_list: function() {
                const _this = this;
                this.$store.dispatch('article/get_data').then(data => {
                    _this.$message.success("成功获取文章列表")
                })
            },
            changeState: function(index, row) {
                const state = row.state?1:0;
                const new_state = state, _this = this, msg = new_state == 0?"下线":"上线";
                this.set_article_state({id: row.id, state: new_state, index: index})
                    .then((x)=>{
                        _this.$message.success(msg + "成功");
                    }).catch((x)=>{
                    _this.$message.error(msg + "失败");
                })
            },
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
                this.get_article_list()
            },
            size_change: function(size) {
                this.set_per_page(size);
                this.get_article_list()
            },
            transfer: function(img) {
                return img?'http://images.jujin8.com'+img.replace('/uploads/crawler', '/uploads'):''
            },
            changeTableSort: function(column) {
                this.set_order_by(column['prop']);
                this.set_order(column['order'] === 'ascending'?'asc':'desc');
                this.get_article_list()
            }
        }
    }
</script>

<style scoped>
    .router-button {
        display: inline-block;
        padding: 7px 15px;
        color: #fff;
        background-color: #f36c10;
        border-color: #f36c10;
        font-size: 12px;
        border-radius: 3px;
        line-height: 12px;
        border: 1px solid #f36c10;
        font-weight: 500;
    }
</style>