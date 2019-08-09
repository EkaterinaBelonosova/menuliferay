--part 1--
<#include "${templatesPath}/99815" />

<#if !entries?has_content>
	<#if themeDisplay.isSignedIn()>
		<div class="alert alert-info">
			<@liferay.language key="there-are-no-menu-items-to-display" />
		</div>
	</#if>
<#else>
	<#assign includeAllChildNavItems = false />

	<#if stringUtil.equals(includedLayouts, "all")>
		<#assign includeAllChildNavItems = true />
	</#if>

	 <nav class="menubar menubar-transparent menubar-vertical-expand-md" style="max-width: 100%;">
    	 <a aria-controls="menubarVerticalCollapse0" aria-expanded="false" class="menubar-toggler" data-toggle="collapse" href="#menubarVerticalCollapse0" role="button">
    		Details
    		<svg class="lexicon-icon lexicon-icon-caret-bottom" focusable="false" role="presentation">
    			<use href="/images/icons/icons.svg#caret-bottom" />
    		</svg>
        </a>
		<@buildNavigation
			branchNavItems=branchNavItems
			cssClass="layouts"
			displayDepth=displayDepth
			includeAllChildNavItems=includeAllChildNavItems
			navItemLevel=1
			navItems=entries
			navid=0
			cssClassdiv="menubar-collapse"
		/>
	</nav>
</#if>


--part 2--
<#macro buildNavigation
	branchNavItems
	cssClass
	displayDepth
	includeAllChildNavItems
	navItemLevel
    navItems
    navid
    cssClassdiv
>
    <#if navItems?has_content && ((displayDepth == 0) || (navItemLevel <= displayDepth))>
    <div class="collapse ${cssClassdiv}" id="menubarVerticalCollapse${navid}">
            <ul class="nav nav-nested">
			<#list navItems as navItem>
				<#assign
					nav_item_css_class = "lfr-nav-item"
				/>

				<#if includeAllChildNavItems || navItem.isInNavigation(branchNavItems)>
					<#assign nav_item_css_class = "${nav_item_css_class} open" />
				</#if>

				<#if navItem.isSelected()>
					<#assign
						nav_item_css_class = "${nav_item_css_class} selected active"
					/>
				</#if>

				<li class="nav-item">
                    <#if navItem.isBrowsable()>                     
                        <a aria-controls="menubarVerticalCollapse${navItem.getLayoutId()}" aria-expanded="false" class="collapsed collapse-icon nav-link" role="button" href="${navItem.getRegularURL()!""}" ${navItem.getTarget()} >
                            ${navItem.getName()}
                        </a>
					<#else>
                    <a aria-controls="menubarVerticalCollapse${navItem.getLayoutId()}" aria-expanded="false" class="collapsed collapse-icon nav-link" data-toggle="collapse" role="button" href="#menubarVerticalCollapse${navItem.getLayoutId()}">
                            ${navItem.getName()}
                            <span class="collapse-icon-closed" id="sovq____"><svg class="lexicon-icon lexicon-icon-angle-right" focusable="false" role="img" title="" viewBox="0 0 512 512"><title>angle-right</title>
                                <path class="lexicon-icon-outline" d="M396.394 255.607c-0.22-6.936-2.973-13.81-8.272-19.111l-227.221-227.221c-11.026-11.059-28.94-11.059-39.999 0-11.058 11.026-11.058 28.941 0 39.999l206.333 206.333c0 0-206.333 206.333-206.333 206.333-11.058 11.058-11.058 28.973 0 39.999 11.059 11.059 28.972 11.059 39.999 0l227.221-227.221c5.3-5.3 8.053-12.175 8.272-19.111z"></path>
                                </svg></span>
                                <span class="collapse-icon-open" id="vyta____"><svg class="lexicon-icon lexicon-icon-angle-down" focusable="false" role="img" title="" viewBox="0 0 512 512"><title>angle-down</title>
                                    <path class="lexicon-icon-outline" d="M256 384c6.936-0.22 13.81-2.973 19.111-8.272l227.221-227.221c11.058-11.026 11.058-28.941 0-39.999-11.026-11.058-28.94-11.058-39.999 0l-206.333 206.333c0 0-206.333-206.333-206.333-206.333-11.059-11.058-28.973-11.058-39.999 0-11.059 11.058-11.059 28.972 0 39.999l227.221 227.221c5.3 5.3 12.174 8.053 19.111 8.272z"></path>
                                    </svg></span>
                        </a>
					</#if>

					<#if includeAllChildNavItems || navItem.isInNavigation(branchNavItems)>
						<@buildNavigation
							branchNavItems=branchNavItems
							cssClass=cssClass
							displayDepth=displayDepth
							includeAllChildNavItems=includeAllChildNavItems
							navItemLevel=(navItemLevel + 1)
                            navItems=navItem.getChildren()
                            navid=navItem.getLayoutId()
                            cssClassdiv=""
						/>
					</#if>
				</li>
			</#list>
		</ul>
    </div>
	</#if>
</#macro>
