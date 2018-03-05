var user_vue=new Vue({el:"#userDiv",data:{isMobile:!1,default_date:"",type:"buyer",profileUSERID:"",summary:null,description:null,license:[],career:[],summaryInformation:"",descriptionInformation:"",licenseInformation:"",licensed_at:"",licensed_provider_center:"",careerInformation:"",period_start:"",period_end:"",limitUserMetadataCnt:5,user_metadata:[],isEditUserMetadata:!1,selected_category_for_user_metadata:"",user_metadata_tag_list:[],selected_metadata:[],needToRemoveCertificationFiles:[],need_certification_selected_metadata:[],user_metadata_etc:"",ratingsPage:1,gigsTotalCnt:0,topGigPID:null},ready:function(){},watch:{type:function(){},licenseInformation:function(e){""!=e&&this.hideErrorMessage("license","description")},licensed_at:function(e){""!=e&&this.hideErrorMessage("license","licensed_at")},licensed_provider_center:function(e){""!=e&&this.hideErrorMessage("license","licensed_provider_center")},careerInformation:function(e){""!=e&&this.hideErrorMessage("career","description")},summary:function(){if(this.isMobile){var e=$("#summaryDescription");$("#summaryDescription").height()>40&&(e.css("height","38px"),$("#showMoreDescriptionBtn").show())}},profileUSERID:function(){this.getSelectedUserMetadata(),this.loadUserRatings()},selected_metadata:function(){if($(".userMetadataCloseBtns").show(),$('[data-toggle="tooltip"]').tooltip({html:!0}),this.need_certification_selected_metadata=[],this.selected_metadata.length>0)for(var e in this.selected_metadata)if("object"==typeof this.selected_metadata[e]&&"WAITING"==this.selected_metadata[e].status&&1==this.selected_metadata[e].user_metadata.need_certification&&this.need_certification_selected_metadata.push(this.selected_metadata[e]),e==this.selected_metadata.length-1)break},need_certification_selected_metadata:function(){settingFileUpload(),$(".file-input-wrapper").hide();var e=!1;for(var t in this.need_certification_selected_metadata)if("object"==typeof this.selected_metadata[t]&&"WAITING"==this.need_certification_selected_metadata[t].status&&null!=this.need_certification_selected_metadata[t].file_id&&(e=!0),t==this.need_certification_selected_metadata.length-1)break;1==e?$("#certificatedReady").show():$("#certificatedReady").hide()},career:function(){$(".date-input").datepicker({format:"yyyy.mm",maxViewMode:2,minViewMode:"months",orientation:"bottom",endDate:"0m",language:"kr",autoclose:!0,todayHighlight:!0})},selected_category_for_user_metadata:function(e){for(var t in this.user_metadata)if("object"==typeof this.user_metadata[t]&&this.user_metadata[t].category_id==e&&(this.user_metadata_tag_list=this.user_metadata[t].tags),t==this.user_metadata.length-1)break}},filters:{number_format:function(e){return void 0!==e?e.format():0},nl2br:function(e){return"undefined"!=typeof e&&null!=e?e.replace(/\n/g,"<br>"):""},htmlUnescape:function(e){return e.replace(/&quot;/g,'"').replace(/&#39;/g,"'").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&amp;/g,"&")}},methods:{openUpdateUserMetadata:function(){this.isEditUserMetadata=!0},loadMoreUserGigs:function(){var e={USERID:this.profileUSERID,page:2,type:this.type,exceptPID:this.topGigPID},t=$("#loadMoreUserGigsBtn").html(),a="#loadMoreUserGigsBtn";createBallFall(a,"color-black"),$.ajax({type:"GET",url:"/profile/load_user_gigs",data:e,dataType:"json",success:function(e){1==e.meta.status&&($("#userGigsDiv").append(e.data.section),$("#loadMoreUserGigBtnWrapper").hide()),e.meta.status==-1&&rollbackBallFall(a,t)}})},loadUserRatings:function(e){var t={USERID:this.profileUSERID,page:this.ratingsPage},a="#loadUserRatingsBtn";1!=this.ratingsPage&&createBallFall(a,"color-black"),$.ajax({type:"GET",url:"/profile/load_user_ratings",data:t,dataType:"json",success:function(e){1==e.meta.status&&($("#userRatingsDiv").append(e.data.section),1==e.data.hasMorePages?(user_vue.ratingsPage++,rollbackBallFall(a,e.data.nexPageRatingsCount+"개 더보기"),$("#loadUSerRatingsBtnWrapper").show()):$("#loadUSerRatingsBtnWrapper").hide()),e.meta.status==-1&&rollbackBallFall(a,html)}})},getSelectedUserMetadata:function(){var e={USERID:this.profileUSERID};$.ajax({type:"GET",url:"/api/common/get_user_metadata_information_by_user_id",data:e,dataType:"json",success:function(e){1==e.meta.status&&(user_vue.selected_metadata=e.data.selected_user_metadata,0==user_vue.selected_metadata.length&&("seller"==user_vue.type&&(user_vue.gigsTotalCnt>0||null!=user_vue.topGigPID)?user_vue.openUpdateUserMetadata():$("#selectedUserMetadataNone").show())),e.meta.status==-1&&0==e.data.selected_user_metadata.length&&("seller"==user_vue.type&&(user_vue.gigsTotalCnt>0||null!=user_vue.topGigPID)?user_vue.openUpdateUserMetadata():$("#selectedUserMetadataNone").show()),$("#selectedUserMetadataLoading").hide()}})},getUserMetadataByCategory:function(e){var t={category_id:e,USERID:this.profileUSERID};$.ajax({type:"GET",url:"/api/common/get_user_metadata_information_by_category_id",data:t,dataType:"json",success:function(t){if(1==t.meta.status)for(var a in user_vue.user_metadata)if("object"==typeof user_vue.user_metadata[a]&&user_vue.user_metadata[a].category_id==e&&(user_vue.user_metadata[a].tags=t.data.tags,0==a&&(user_vue.selected_category_for_user_metadata=e)),a==user_vue.user_metadata.length-1)break}})},openCreateInput:function(e){$("#"+e+"View").hide(),$("#"+e+"EditBtnGroup").hide(),$("#"+e+"Input").show()},openUpdateInput:function(e,t){"undefined"!=typeof t&&(this[e+"Information"]=this[e][t].data.description),"undefined"==typeof t&&(this[e+"Information"]=this[e].data.description),$("#"+e+"Input").show(),$("#"+e+"View").hide()},hideCreateInput:function(e){"career"==e&&(this.period_start=this.default_date,this.period_end=""),"license"==e&&(this.licensed_at=this.default_date,this.licensed_provider_center=""),this[e+"Information"]="",$("#"+e+"Input").hide(),$("#"+e+"EditBtnGroup").show(),"description"!=e&&"summary"!=e&&("career"!=e&&"license"!=e||0!=this[e].length)||$("#"+e+"View").show()},createUserInformation:function(e){var t="/profile/create_user_information",a={type:e,description:this[e+"Information"],USERID:this.profileUSERID};if("summary"==e&&this[e+"Information"].length>50)return sweetalertByType("글자수 제한","한줄 소개는 최대 50자 까지 입력가능합니다.","info","timer"),!1;"career"==e&&(a.period_start=this.period_start,a.period_end=this.period_end),"license"==e&&(a.licensed_at=this.licensed_at,a.licensed_provider_center=this.licensed_provider_center);var i=this.validation(e,a);return i.length>0?(this.showErrorMessage(e,i),!1):void $.ajax({type:"POST",url:t,data:a,dataType:"json",success:function(t){if(1==t.meta.status){if("career"==e||"license"==e){var i={description:a.description};"undefined"!=typeof a.period_start&&(i.period_start=a.period_start,i.period_end=a.period_end),"undefined"!=typeof a.licensed_at&&(i.licensed_at=a.licensed_at),"undefined"!=typeof a.licensed_provider_center&&(i.licensed_provider_center=a.licensed_provider_center),user_vue[e].push({id:t.data.id,data:i})}"summary"!=e&&"description"!=e||(user_vue[e]={id:t.data.id,data:{description:a.description}}),user_vue.hideCreateInput(e)}}})},openUpdateUserInformation:function(e,t,a){var i=$("#"+e+"_"+t+"_input"),s=$("#"+e+"_"+t+"_view"),r=$("."+e+"UserInformationEditBtnGroup"),n=$("#"+e+"EditBtnGroup");if("undefined"!=typeof a){var d=this[e][a].data;this[e+"Information"]=d.description,"career"==e&&(this.period_start=d.period_start,this.period_end=d.period_end),"license"==e&&(this.licensed_at=d.licensed_at,this.licensed_provider_center=d.licensed_provider_center);var o=this.validation(e,d);o.length>0&&this.showErrorMessage(e,o,t)}"undefined"==typeof a&&(this[e+"Information"]=this[e].data.description),s.hide(),r.hide(),n.hide(),i.show()},hideUpdateUserInformation:function(e,t,a){var i=$("#"+e+"_"+t+"_input"),s=$("#"+e+"_"+t+"_view"),r=$("."+e+"UserInformationEditBtnGroup"),n=$("#"+e+"EditBtnGroup");"career"==e&&(this.period_start=this.default_date,this.period_end=""),"license"==e&&(this.licensed_at=this.default_date,this.licensed_provider_center=""),this[e+"Information"]="",s.show(),r.show(),n.show(),i.hide(),this.hideErrorMessageById(e,"description",t),"career"==e&&this.hideErrorMessageById(e,"period_start",t),"license"==e&&(this.hideErrorMessageById(e,"licensed_at",t),this.hideErrorMessageById(e,"licensed_provider_center",t))},updateUserInformation:function(e,t,a){var i={USERID:this.profileUSERID,type:e,userInformationId:t,description:this[e+"Information"]};"career"==e&&(i.period_start=this.period_start,i.period_end=this.period_end),"license"==e&&(i.licensed_at=this.licensed_at,i.licensed_provider_center=this.licensed_provider_center);var s=this.validation(e,i);return s.length>0?(this.showErrorMessage(e,s,t),!1):void $.ajax({type:"POST",url:"/profile/update_user_information",data:i,dataType:"json",success:function(s){if(1==s.meta.status){if("career"==e||"license"==e){var r={description:i.description};"undefined"!=typeof i.period_start&&(r.period_start=i.period_start,r.period_end=i.period_end),"undefined"!=typeof i.licensed_at&&(r.licensed_at=i.licensed_at),"undefined"!=typeof i.licensed_provider_center&&(r.licensed_provider_center=i.licensed_provider_center),user_vue[e][a].data=r}"summary"!=e&&"description"!=e||(user_vue[e].data={description:i.description}),user_vue.hideUpdateUserInformation(e,t,a)}}})},deleteUserInformation:function(e,t,a,i){var s=0;"restore"==i&&(s=1);var r={USERID:this.profileUSERID,type:e,userInformationId:t,status:s};$.ajax({type:"POST",url:"/profile/delete_user_information",data:r,dataType:"json",success:function(t){1==response.meta.status&&user_vue[e].splice(a,1)}})},selectUserMetadata:function(e,t,a){var i={USERID:this.profileUSERID,user_metadata_id:t,action:a,limitUserMetadataCount:this.limitUserMetadataCnt};if("enable"==a&&this.selected_metadata.length>=this.limitUserMetadataCnt){var s=$("#limitUserMetadataCntError"),r=$("#userMetadataWrapper");return s.show(),r.addClass("bg-color-light-red").css("transition","background 0.6s ease"),setTimeout(function(){r.removeClass("bg-color-light-red"),s.fadeOut()},2e3),!1}$.ajax({type:"POST",url:"/profile/set_user_metadata",data:i,dataType:"json",success:function(e){if(1==e.meta.status)for(var i in user_vue.user_metadata){var s=user_vue.user_metadata[i];if("object"==typeof s)for(var r in s.tags){var n=s.tags[r];if("object"==typeof s&&n.id==t){n.selected_user_metadata=e.data.selected_user_metadata;var d=-1;for(var o in user_vue.selected_metadata){var c=user_vue.selected_metadata[o];if("object"==typeof c&&c.user_metadata.id==t&&(d=o),o==user_vue.selected_metadata.length-1)break}"enable"==a&&d==-1&&user_vue.selected_metadata.push(e.data.selected_user_metadata),"disable"==a&&d!=-1&&user_vue.selected_metadata.splice(d,1)}if(r==s.tags.length-1)break}if(i==user_vue.user_metadata.length-1)break}}})},submitCertificationFiles:function(){if(this.needToRemoveCertificationFiles.length>0){for(var e in this.needToRemoveCertificationFiles){if("object"==typeof this.needToRemoveCertificationFiles[e]){var t=this.needToRemoveCertificationFiles[e].id;this.deleteFile(t,this.needToRemoveCertificationFiles[e].file_id.FID)}if(e==this.needToRemoveCertificationFiles.length-1)break}this.needToRemoveCertificationFiles=[]}var a=[],i=[];for(var e in this.need_certification_selected_metadata){var s=this.need_certification_selected_metadata[e];if("object"==typeof s&&(1==s.user_metadata.need_certification&&"WAITING"==s.status&&null!=s.file_id?a.push(s):i.push(s)),e==this.need_certification_selected_metadata.length-1)break}if(a.length>0){var r={selected_metadata:a,USERID:this.profileUSERID};$.ajax({type:"POST",url:"/profile/update_file_in_selected_metadata",data:r,dataType:"json",success:function(e){1==e.meta.status&&($("#certificatedReady").show(),$("#tagCertificationModal").modal("hide"))}})}0==a.length&&($("#certificatedReady").hide(),$("#tagCertificationModal").modal("hide"))},submitUserMetadataEtcToKmong:function(e){if(""!=this.user_metadata_etc){var t={recommend_user_metadata_etc:this.user_metadata_etc},a=$(e.target);a.html('&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-spin fa-spinner"></i>&nbsp;&nbsp;&nbsp;&nbsp;'),a.attr("disabled","disabled"),$.ajax({type:"POST",url:"/profile/recommend_user_metadata_etc_to_kmong",data:t,dataType:"json",success:function(t){1==t.meta.status&&(user_vue.user_metadata_etc="",sweetalertByType("태그추천 요청 성공","전문가 태그 추천해주셔서 감사합니다.<br/> 추후 반영하도록하겠습니다.","success","timer"),rollbackBallFall(e.target,"보내기"))}})}},validation:function(e,t){var a=[];return"undefined"!=typeof t.description&&""!=t.description||a.push("description"),"career"==e&&("undefined"!=typeof t.period_start&&""!=t.period_start||a.push("period_start")),"license"==e&&("undefined"!=typeof t.licensed_at&&""!=t.licensed_at||a.push("licensed_at"),"undefined"!=typeof t.licensed_provider_center&&""!=t.licensed_provider_center||a.push("licensed_provider_center")),a},showErrorMessage:function(e,t,a){for(var i in t){if("string"==typeof t[i]){var s="#"+e+"_"+t[i],r="";"undefined"!=typeof a&&(s+="_"+a),r=s+"_input",s+="_error",$(s).removeClass("hidden"),$(r).parent().addClass("has-error")}if(i==t.length-1)break}},hideErrorMessage:function(e,t){var a=$("."+e+"_"+t+"_error"),i=$("."+e+"_"+t+"_input");a.each(function(){$(this).hasClass("hidden")||$(this).addClass("hidden")}),i.each(function(){$(this).parent().hasClass("has-error")&&$(this).parent().removeClass("has-error")})},hideErrorMessageById:function(e,t,a){var i=$("#"+e+"_"+t+"_"+a+"_error"),s=$("#"+e+"_"+t+"_"+a+"_input");i.hasClass("hidden")||i.addClass("hidden"),s.parent().hasClass("has-error")&&s.parent().removeClass("has-error")},restoreFiles:function(){if(this.needToRemoveCertificationFiles.length>0){for(var e in this.needToRemoveCertificationFiles){if("object"==typeof this.needToRemoveCertificationFiles[e]){var t=this.needToRemoveCertificationFiles[e].id;for(var a in this.need_certification_selected_metadata)if("object"==typeof this.need_certification_selected_metadata[a]&&this.need_certification_selected_metadata[a].id==t&&(this.need_certification_selected_metadata[a].file_id={FID:this.needToRemoveCertificationFiles[e].file_id.FID,ori_fname:this.needToRemoveCertificationFiles[e].file_id.ori_fname}),e==this.need_certification_selected_metadata.length-1)break}if(e==this.needToRemoveCertificationFiles.length-1)break}this.needToRemoveCertificationFiles=[]}$("#tagCertificationModal").modal("hide")},deleteFile:function(e,t){$.ajax({url:"/delete_selected_metadata_file",data:{selected_metadata_id:e,FID:t},method:"POST",dataType:"json",success:function(e){}})}}});