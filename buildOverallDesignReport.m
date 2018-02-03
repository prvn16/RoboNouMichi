function buildOverallDesignReport(modelfile)

import slreportgen.report.*
import slreportgen.finder.*
import mlreportgen.report.*
model = load_system(modelfile);
rpt = slreportgen.report.Report(['sdd_'...
    get_param(model,'Name')],'pdf');
tp = TitlePage;
tp.Title = upper(get_param(model,'Name'));
tp.Subtitle = 'Framework';
tp.Author = 'Dr. Bhatia Praveen';
tp.Image = Diagram(model);
add(rpt,tp);
add(rpt,TableOfContents);
ch = Chapter("Title","Main System");
add(ch,Diagram(model));
finder = BlockFinder(model);
blocks = find(finder);
for block = blocks
    section = Section("Title", ...
        strrep(block.Name, newline, ' '));
    add(section,block);
    add(ch,section);
end
add(rpt,ch)
ch = Chapter("Title","Subsystems");
finder = SystemDiagramFinder(model);
% finder.IncludeRoot = false;

while hasNext(finder)
    system = next(finder);
    section = Section("Title", system.Name);
    add(section,system);
    
    finder1 = BlockFinder(model);
    elems = find(finder1);
    
    for elem = elems
        section = Section("Title",...
            strrep(elem.Name, newline, ' '));
        add(section,elem);
        add(ch,section);
    end
end
add(rpt,ch);
ch = Chapter("Title", "Stateflow Charts");
finder = ChartDiagramFinder(model);
while hasNext(finder)
    chart = next(finder);
    section = Section("Title",chart.Name);
    add(section,chart);
    
    objFinder = StateflowDiagramElementFinder(model);
    sfObjects = find(objFinder);
    for sfObj = sfObjects
        title = sfObj.Name;
        if isempty(title)
            title = sfObj.Type;
        end
        objSection = Section("Title", title);
        add(objSection,sfObj);
        add(section,objSection);
    end
    add(ch,section);
end
add(rpt,ch);
% chartFinder = ChartDiagramFinder(model);
% while hasNext(chartFinder)
%     chart = next(chartFinder);
%     chapter = Chapter("Title",chart.Name);
%     add(chapter, chart);
%     sect = Section("Title","States");
%     stateFinder = StateFinder("Container",chart.Object);
%     states = find(stateFinder);
%     for state = states
%         add(sect,state);
%     end
%     add(chapter,sect);
%     
%     sect = Section("Title","Transitions");
%     transitionFinder = StateflowDiagramElementFinder("Container",...
%         chart.Object, "Types", "transition");
%     transitions = find(transitionFinder);
%     for transition = transitions
%         add(sect,transition);
%     end
%     add(chapter,sect);
%     add(rpt, chapter);
% end
close(rpt);
rptview(rpt);
close_system(model);