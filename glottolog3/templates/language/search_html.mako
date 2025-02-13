<%inherit file="../glottolog3.mako"/>
<%namespace name="util" file="../util.mako"/>
<%! active_menu_item = "search" %>

<h3>Search languages, families, and dialects</h3>
<div class="span4 well well-small">
    <form>
        <fieldset>
            <legend>Name (primary or alternative)</legend>
            <input tabindex="3" type="text" name="name" id="inputName" placeholder="Name" value="${'' if message else params['name']}">
            <label class="radio">
                <input tabindex="3" type="radio" name="namequerytype" value="whole" ${'checked' if params['namequerytype'] == 'whole' else ''}>
                match whole name
            </label>
            <label class="radio">
                <input tabindex="3" type="radio" name="namequerytype" value="part" ${'checked' if params['namequerytype'] == 'part' else ''}>
                match part of name
            </label>
            <label class="checkbox">
                <input tabindex="3" type="checkbox" name="multilingual" ${'checked' if params['multilingual'] else ''}> include non-English names
            </label>
            <button tabindex="3" type="submit" class="btn">Submit</button>
        </fieldset>
    </form>
    <form>
        <fieldset>
            <legend>ISO 639-3</legend>
            <div class="input-append">
                <input tabindex="3" class="input-small" type="text" name="iso" id="inputIso" value="${'' if message else params['iso']}" placeholder="abc">
                <button tabindex="3" type="submit" class="btn">Submit</button>
            </div>
        </fieldset>
    </form>
    <form>
        <fieldset>
            <legend>Glottocode</legend>
            <div class="input-append">
                <input tabindex="3" class="input-small" type="text" name="alnum" id="inputAlnum" placeholder="abcd1234">
                <button tabindex="3" type="submit" class="btn">Submit</button>
            </div>
        </fieldset>
    </form>
    <form>
        <fieldset>
            <legend>Country</legend>
            <div class="input-append">
                <input tabindex="3" type="text" name="country" data-provide="typeahead" data-source="${countries}" placeholder="DE">
                <button tabindex="3" class="btn" type="submit">Submit</button>
            </div>
        </fieldset>
    </form>
</div>
<div class="span7">
    % if message:
    <div class="alert alert-error"><p>${message}</p></div>
    % else:
    <%util:table items="${languoids}" args="item" class_="table-condensed table-striped">\
        <%def name="head()">
            <th>Glottocode</th>
            <th>Name</th>
            ##<th>Type</th>
            ##<th>Status</th>
            <th>Family</th>
        </%def>
        <td>${h.link(request, item, label=item.id)}</td>
        <td class="level-${item.level.value}">${h.link(request, item)}</td>
        ##<td>${item.level}</td>
        ##<td>${item.status or ''}</td>
        <td>${u.languoid_link(request, item.family) if item.family else ''}</td>
        ##<td>${', '.join(n.name for n in item.identifiers if n.type == 'iso639-3')}</td>
    </%util:table>
    % endif
    % if map:
    <div class="accordion" id="sidebar-accordion" style="margin-top: 1em;">
        <%util:accordion_group eid="acc-map" parent="sidebar-accordion" title="Map" open="${True}">
            ${map.render()}
        </%util:accordion_group>
    </div>
    % endif
</div>
