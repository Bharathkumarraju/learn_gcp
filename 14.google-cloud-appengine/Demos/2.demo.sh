App Engine APP:
------------------>
Single regional application resource consisting of hierarchy of
Services,Versions,Instances

Instances:
1.Resident instances:  Runs all the times, no latency
2.Dynamic instances: starts uo and shuts down instances based on application needs


Scaling:
1.Manual scaling: Uses resident instances to serve traffic, useful for applications that rely on the state of memory over time.
2.Automatic scaling:  Uses both Resident instances and Dynamic instances
3.Basic Scaling: uses only Dynamic instances, applications that live intermittently can use this

Instance Classes:
------------------->
Instance classes starts with letter "F" support automatic scaling.
Instance classes starts with letter "B" supports both manual and basic scaling.




