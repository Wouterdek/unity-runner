FROM gableroux/unity3d:2019.3.0f1

LABEL "com.github.actions.name"="Unity Runner"
LABEL "com.github.actions.description"="Run unity any Unity project."
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="http://github.com/MirrorNG/unity-runner"
LABEL "homepage"="http://github.com/MirrorNG/unity-runner"
LABEL "maintainer"="Paul Pacheco <paulpach@gmail.com>"

# install sonar scanner
RUN /opt/Unity/Editor/Data/NetCore/Sdk-2.2.107/dotnet tool install dotnet-sonarscanner --tool-path . --version 4.7.1

COPY unity_csc.sh.patch .
RUN patch /opt/Unity/Editor/Data/Tools/RoslynScripts/unity_csc.sh unity_csc.sh.patch

COPY entrypoint.sh /entrypoint.sh
COPY activate.sh /activate.sh
COPY sonar-scanner.sh /sonar-scanner.sh

ADD request_activation.sh /request_activation.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /activate.sh
RUN chmod +x /request_activation.sh
RUN chmod +x /sonar-scanner.sh

ENTRYPOINT ["/entrypoint.sh"]
