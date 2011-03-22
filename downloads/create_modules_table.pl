#!/usr/bin/perl
#
# Generate a release table row for each bundle to be released
# Needs a text file called aries_release_versions.txt. This needs to be updated with the
# right version information before running the script.
#


# Distribution directories
$cgi = "http://www.apache.org/dyn/closer.cgi/aries/";
$dist = "http://www.apache.org/dist/aries/";

$oaa = "org.apache.aries.";

#HTML fragments
$open_td = "<td class=\"confluenceTd\"\>";
$close_td = "</td>";
$open_tr = "<tr>";
$close_tr = "</tr>";
$ar = "<A href=\"";
$c_jar = "\">jar</A>";
$c_asc = "\">asc</A>";
$c_md5 = "\">md5</A>";
$c_sha1 = "\">sha1</A>";

open (MOD, "aries_release_versions.txt");

while (<MOD>) {
    if (/Module: (\w+)/i) {
        $module = $1;
        print_module_header();
        # print "$module \n";
        while (<MOD>) {
            last if (/ModuleEnd/i); 
            next if (/^#/);
            chomp;
            ($bundle, $version) = split(/,/, $_); 
            print_table_row();
         #    print "$bundle $version \n";
       } 
    }
}

foreach $keys (%bundle_info) {
    print;
}

sub print_module_header {
    print $open_tr.$open_td." ".$module." ".$close_td.$open_td.$close_td.$open_td." - ".$close_td.$open_td." - " .$close_td.$open_td." - ".$close_td.$open_td.$close_td.$close_tr."\n";
}


sub print_table_row {

    $jar = $bundle."-".$version.".jar";
    $asc = $bundle."-".$version.".jar.asc";
    $md5 = $bundle."-".$version.".jar.md5";
    $sha1 = $bundle."-".$version.".jar.sha1";

    $s_jar = $bundle."-".$version.".sources.jar";
    $s_asc = $bundle."-".$version.".sources.jar.asc";
    $s_md5 = $bundle."-".$version.".sources.jar.md5";
    $s_sha1 = $bundle."-".$version.".sources.jar.sha1";

    $line1 = $ar.$cgi.$oaa.$jar.$c_jar.
             " (".
             $ar.$dist.$oaa.$asc.$c_asc.
             ", ".
             $ar.$dist.$oaa.$md5.$c_md5.
             ", ".
             $ar.$dist.$oaa.$sha1.$c_sha1.
             ")";

    $line2 = $ar.$cgi.$oaa.$s_jar.$c_jar.
             " (".
             $ar.$dist.$oaa.$s_asc.$c_asc.
             ", ".
             $ar.$dist.$oaa.$s_md5.$c_md5.
             ", ".
             $ar.$dist.$oaa.$s_sha1.$c_sha1.
             ")";
             
    print $open_tr.$open_td.$close_td.$open_td." ".$bundle." ".$close_td.$open_td." ".$version." ".$close_td.$open_td."\n";
    print $line1."\n";
    print $close_td.$open_td."\n";
    print $line2."\n";
    print $close_td.$open_td.$close_td.$close_tr."\n";
}
